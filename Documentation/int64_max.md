# Maximum Int64 Number

Many shell implementations support 64-bit numbers, but there is a problem with
parsing their maximum values. Some shell implementations handle this
differently.

It is notable that the behavior differs between dash and ash from busybox.

## Agenda

* zsh - zsh (5.9) - UNIX Shell similar to the Korn shell (https://www.zsh.org/)
* dash - dash (0.5.12) - Debian Almquist Shell (https://git.kernel.org/pub/scm/utils/dash/dash.git)
* bash - bash (5.3_p3) - GNU Bourne-Again Shell (https://git.savannah.gnu.org/cgit/bash.git)
* ksh - loksh (7.7) - Linux port of OpenBSD's ksh (https://github.com/dimkr/loksh/)
* lksh - mksh (59c) - MirBSD Korn Shell (https://mbsd.evolvis.org/mksh.htm)
* ash - busybox (1.36.1) - Tiny utilities for small and embedded systems (https://busybox.net/)

## Value Calculation

```sh
$ for sh in zsh dash bash ksh lksh "busybox ash"; do $sh -c 'printf "OUT: %4s: %d\n" "$0" $(( 1 << 62 ))'; done
OUT:  zsh: 4611686018427387904
OUT: dash: 4611686018427387904
OUT: bash: 4611686018427387904
OUT:  ksh: 4611686018427387904
OUT: lksh: 4611686018427387904
OUT:  ash: 4611686018427387904

$ for sh in zsh dash bash ksh lksh "busybox ash"; do $sh -c 'printf "OUT: %4s: %s\n" "$0" $(( 1 << 63 ))'; done
OUT:  zsh: -9223372036854775808
OUT: dash: -9223372036854775808
OUT: bash: -9223372036854775808
OUT:  ksh: -9223372036854775808
OUT: lksh: -9223372036854775808
OUT:  ash: -9223372036854775808

$ for sh in zsh dash bash ksh lksh "busybox ash"; do $sh -c 'printf "OUT: %4s: %x\n" "$0" $(( 1 << 63 ))'; done
zsh:1: number truncated after 18 digits: 9223372036854775808
OUT:  zsh: f333333333333334
OUT: dash: 8000000000000000
OUT: bash: 8000000000000000
OUT:  ksh: 8000000000000000
OUT: lksh: 8000000000000000
OUT:  ash: 8000000000000000
```

```sh
$ for sh in zsh dash bash ksh lksh "busybox ash"; do $sh -c 'printf "OUT: %4s: %s\n" "$0" $(( 0x7fffffffffffffff + 1 ))'; done
OUT:  zsh: -9223372036854775808
OUT: dash: -9223372036854775808
OUT: bash: -9223372036854775808
OUT:  ksh: -9223372036854775808
OUT: lksh: -9223372036854775808
OUT:  ash: -9223372036854775808

$ for sh in zsh dash bash ksh lksh "busybox ash"; do $sh -c 'printf "OUT: %4s: %x\n" "$0" $(( 0x7fffffffffffffff + 1 ))'; done
zsh:1: number truncated after 18 digits: 9223372036854775808
OUT:  zsh: f333333333333334
OUT: dash: 8000000000000000
OUT: bash: 8000000000000000
OUT:  ksh: 8000000000000000
OUT: lksh: 8000000000000000
OUT:  ash: 8000000000000000

$ for sh in zsh dash bash ksh lksh "busybox ash"; do $sh -c 'printf "OUT: %4s: %x\n" "$0" $(( 0x7fffffffffffffff + 2 ))'; done
OUT:  zsh: 8000000000000001
OUT: dash: 8000000000000001
OUT: bash: 8000000000000001
OUT:  ksh: 8000000000000001
OUT: lksh: 8000000000000001
OUT:  ash: 8000000000000001

$ for sh in zsh dash bash ksh lksh "busybox ash"; do $sh -c 'printf "OUT: %4s: %x\n" "$0" $(( 0x7fffffffffffffff + 3 ))'; done
OUT:  zsh: 8000000000000002
OUT: dash: 8000000000000002
OUT: bash: 8000000000000002
OUT:  ksh: 8000000000000002
OUT: lksh: 8000000000000002
OUT:  ash: 8000000000000002

$ for sh in zsh dash bash ksh lksh "busybox ash"; do $sh -c 'printf "OUT: %4s: %x\n" "$0" $(( 0x7fffffffffffffff + 0x7fffffffffffffff + 1 ))'; done
OUT:  zsh: ffffffffffffffff
OUT: dash: ffffffffffffffff
OUT: bash: ffffffffffffffff
OUT:  ksh: ffffffffffffffff
OUT: lksh: ffffffffffffffff
OUT:  ash: ffffffffffffffff
```

There are anomalies in parsing large numbers:

```sh
$ for sh in zsh dash bash ksh lksh "busybox ash"; do $sh -c 'printf "OUT: %4s: %x\n" "$0" $(( 0xffffffffffffffff ))'; done
zsh:1: number truncated after 15 digits: ffffffffffffffff
OUT:  zsh: fffffffffffffff
OUT: dash: 7fffffffffffffff
OUT: bash: ffffffffffffffff
OUT:  ksh: ffffffffffffffff
OUT: lksh: ffffffffffffffff
OUT:  ash: ffffffffffffffff

$ for sh in zsh dash bash ksh lksh "busybox ash"; do $sh -c 'printf "OUT: %4s: %s\n" "$0" $(( 0x8000000000000000 ))'; done
zsh:1: number truncated after 15 digits: 8000000000000000
OUT:  zsh: 576460752303423488
OUT: dash: 9223372036854775807
OUT: bash: -9223372036854775808
OUT:  ksh: -9223372036854775808
OUT: lksh: -9223372036854775808
OUT:  ash: -9223372036854775808

$ for sh in zsh dash bash ksh lksh "busybox ash"; do $sh -c 'printf "OUT: %4s: %d\n" "$0" $(( -9223372036854775808 ))'; done
zsh:1: number truncated after 18 digits: 9223372036854775808
OUT:  zsh: -922337203685477580
OUT: dash: -9223372036854775807
OUT: bash: -9223372036854775808
OUT:  ksh: -9223372036854775808
OUT: lksh: -9223372036854775808
OUT:  ash: -9223372036854775808
```

## Variables

And one more thing. If you put some value in the variable, then in further
calculations, parsing will happen again, which might have an extra effect.

```sh
$ for sh in zsh dash bash ksh lksh "busybox ash"; do $sh -c 'v=$(( 1 << 62 )); printf "OUT: %4s: %x\n" $0 $(( $v ))'; done
OUT:  zsh: 4000000000000000
OUT: dash: 4000000000000000
OUT: bash: 4000000000000000
OUT:  ksh: 4000000000000000
OUT: lksh: 4000000000000000
OUT:  ash: 4000000000000000

$ for sh in zsh dash bash ksh lksh "busybox ash"; do $sh -c 'v=0x7fffffffffffffff; printf "OUT: %4s: %x\n" $0 $(( $v ))'; done
OUT:  zsh: 7fffffffffffffff
OUT: dash: 7fffffffffffffff
OUT: bash: 7fffffffffffffff
OUT:  ksh: 7fffffffffffffff
OUT: lksh: 7fffffffffffffff
OUT:  ash: 7fffffffffffffff

$ for sh in zsh dash bash ksh lksh "busybox ash"; do $sh -c 'v=$(( 1 << 63 )); printf "OUT: %4s: %x\n" $0 $(( $v ))'; done
zsh:1: number truncated after 18 digits: 9223372036854775808
OUT:  zsh: f333333333333334
OUT: dash: 8000000000000001
OUT: bash: 8000000000000000
OUT:  ksh: 8000000000000000
OUT: lksh: 8000000000000000
OUT:  ash: 8000000000000000

$ for sh in zsh dash bash ksh lksh "busybox ash"; do $sh -c 'v=0x8000000000000000; printf "OUT: %4s: %x\n" $0 $(( $v ))'; done
zsh:1: number truncated after 15 digits: 8000000000000000
OUT:  zsh: 800000000000000
OUT: dash: 7fffffffffffffff
OUT: bash: 8000000000000000
OUT:  ksh: 8000000000000000
OUT: lksh: 8000000000000000
OUT:  ash: 8000000000000000

$ for sh in zsh dash bash ksh lksh "busybox ash"; do $sh -c 'v=$(( 0x7fffffffffffffff + 1 )); printf "OUT: %4s: %x\n" $0 $(( $v ))'; done
zsh:1: number truncated after 18 digits: 9223372036854775808
OUT:  zsh: f333333333333334
OUT: dash: 8000000000000001
OUT: bash: 8000000000000000
OUT:  ksh: 8000000000000000
OUT: lksh: 8000000000000000
OUT:  ash: 8000000000000000

for sh in zsh dash bash ksh lksh "busybox ash"; do $sh -c 'v="(0x7fffffffffffffff + 1)"; printf "OUT: %4s: %x\n" $0 $(( $v ))'; done
zsh:1: number truncated after 18 digits: 9223372036854775808
OUT:  zsh: f333333333333334
OUT: dash: 8000000000000000
OUT: bash: 8000000000000000
OUT:  ksh: 8000000000000000
OUT: lksh: 8000000000000000
OUT:  ash: 8000000000000000
```

It seems that if one wants to have the value `1 << 63` in a variable, it is more
correct to keep it as "(0x7fffffffffffffff + 1)" string.

--
Rgrds, legion
