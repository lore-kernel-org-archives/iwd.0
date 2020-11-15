Content-Type: multipart/mixed; boundary="===============6775146338385946399=="
MIME-Version: 1.0
From: mstromberger@aon.at
Subject: Segmentation Fault in nl80211_get_reg_do
Date: Sun, 15 Nov 2020 11:27:44 +0000
Message-ID: <20201115112744.2865.38689@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6775146338385946399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I get a segmentation fault (logged on each boot) in  nl80211_get_reg_do. Af=
ter a research the segmentation could tracked down to iwd version > 1.7
Firmware for regdb (wireless-regdb) is installed and configured. Can you pl=
ease have a look at the debug output?.

greetings
Martin Stromberger

-- Logs begin at Sun 2020-11-15 12:05:19 CET, end at Sun 2020-11-15 12:05:4=
4 CET. --
Nov 15 12:05:19 deepblue kernel: microcode: microcode updated early to revi=
sion 0xe2, date =3D 2020-07-14
Nov 15 12:05:19 deepblue kernel: Linux version 5.4.63-a (root(a)deepblue) (=
gcc version 10.2.0 (GCC)) #1 SMP PREEMPT Sat Nov 7 17:46:03 CET 2020
Nov 15 12:05:19 deepblue kernel: Command line: initrd=3D\intel-ucode.img ro=
ot=3D/dev/sda2 rootfstype=3Dext4 rw quiet loglevel=3D2 mds=3Dfull
Nov 15 12:05:19 deepblue kernel: x86/fpu: Supporting XSAVE feature 0x001: '=
x87 floating point registers'
Nov 15 12:05:19 deepblue kernel: x86/fpu: Supporting XSAVE feature 0x002: '=
SSE registers'
Nov 15 12:05:19 deepblue kernel: x86/fpu: Supporting XSAVE feature 0x004: '=
AVX registers'
Nov 15 12:05:19 deepblue kernel: x86/fpu: Supporting XSAVE feature 0x008: '=
MPX bounds registers'
Nov 15 12:05:19 deepblue kernel: x86/fpu: Supporting XSAVE feature 0x010: '=
MPX CSR'
Nov 15 12:05:19 deepblue kernel: x86/fpu: xstate_offset[2]:  576, xstate_si=
zes[2]:  256
Nov 15 12:05:19 deepblue kernel: x86/fpu: xstate_offset[3]:  832, xstate_si=
zes[3]:   64
Nov 15 12:05:19 deepblue kernel: x86/fpu: xstate_offset[4]:  896, xstate_si=
zes[4]:   64
Nov 15 12:05:19 deepblue kernel: x86/fpu: Enabled xstate features 0x1f, con=
text size is 960 bytes, using 'compacted' format.
Nov 15 12:05:19 deepblue kernel: BIOS-provided physical RAM map:
Nov 15 12:05:19 deepblue kernel: BIOS-e820: [mem 0x0000000000000000-0x00000=
00000057fff] usable
Nov 15 12:05:19 deepblue kernel: BIOS-e820: [mem 0x0000000000058000-0x00000=
00000058fff] reserved
Nov 15 12:05:19 deepblue kernel: BIOS-e820: [mem 0x0000000000059000-0x00000=
0000009dfff] usable
Nov 15 12:05:19 deepblue kernel: BIOS-e820: [mem 0x000000000009e000-0x00000=
0000009ffff] reserved
Nov 15 12:05:19 deepblue kernel: BIOS-e820: [mem 0x0000000000100000-0x00000=
00036bd0fff] usable
Nov 15 12:05:19 deepblue kernel: BIOS-e820: [mem 0x0000000036bd1000-0x00000=
00036bd1fff] ACPI NVS
Nov 15 12:05:19 deepblue kernel: BIOS-e820: [mem 0x0000000036bd2000-0x00000=
00036bfbfff] reserved
Nov 15 12:05:19 deepblue kernel: BIOS-e820: [mem 0x0000000036bfc000-0x00000=
0003e20ffff] usable
Nov 15 12:05:19 deepblue kernel: BIOS-e820: [mem 0x000000003e210000-0x00000=
0003e512fff] reserved
Nov 15 12:05:19 deepblue kernel: BIOS-e820: [mem 0x000000003e513000-0x00000=
0003e54afff] ACPI data
Nov 15 12:05:19 deepblue kernel: BIOS-e820: [mem 0x000000003e54b000-0x00000=
0003ee3cfff] ACPI NVS
Nov 15 12:05:19 deepblue kernel: BIOS-e820: [mem 0x000000003ee3d000-0x00000=
0003f2fefff] reserved
Nov 15 12:05:19 deepblue kernel: BIOS-e820: [mem 0x000000003f2ff000-0x00000=
0003f2fffff] usable
Nov 15 12:05:19 deepblue kernel: BIOS-e820: [mem 0x000000003f300000-0x00000=
0003f3fffff] reserved
Nov 15 12:05:19 deepblue kernel: BIOS-e820: [mem 0x00000000e0000000-0x00000=
000efffffff] reserved
Nov 15 12:05:19 deepblue kernel: BIOS-e820: [mem 0x00000000fe000000-0x00000=
000fe010fff] reserved
Nov 15 12:05:19 deepblue kernel: BIOS-e820: [mem 0x00000000fec00000-0x00000=
000fec00fff] reserved
Nov 15 12:05:19 deepblue kernel: BIOS-e820: [mem 0x00000000fee00000-0x00000=
000fee00fff] reserved
Nov 15 12:05:19 deepblue kernel: BIOS-e820: [mem 0x00000000ff000000-0x00000=
000ffffffff] reserved
Nov 15 12:05:19 deepblue kernel: BIOS-e820: [mem 0x0000000100000000-0x00000=
0047effffff] usable
Nov 15 12:05:19 deepblue kernel: NX (Execute Disable) protection: active
Nov 15 12:05:19 deepblue kernel: e820: update [mem 0x333f7018-0x33407c57] u=
sable =3D=3D> usable
Nov 15 12:05:19 deepblue kernel: e820: update [mem 0x333f7018-0x33407c57] u=
sable =3D=3D> usable
Nov 15 12:05:19 deepblue kernel: extended physical RAM map:
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x000000000000000=
0-0x0000000000057fff] usable
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x000000000005800=
0-0x0000000000058fff] reserved
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x000000000005900=
0-0x000000000009dfff] usable
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x000000000009e00=
0-0x000000000009ffff] reserved
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x000000000010000=
0-0x00000000333f7017] usable
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x00000000333f701=
8-0x0000000033407c57] usable
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x0000000033407c5=
8-0x0000000036bd0fff] usable
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x0000000036bd100=
0-0x0000000036bd1fff] ACPI NVS
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x0000000036bd200=
0-0x0000000036bfbfff] reserved
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x0000000036bfc00=
0-0x000000003e20ffff] usable
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x000000003e21000=
0-0x000000003e512fff] reserved
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x000000003e51300=
0-0x000000003e54afff] ACPI data
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x000000003e54b00=
0-0x000000003ee3cfff] ACPI NVS
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x000000003ee3d00=
0-0x000000003f2fefff] reserved
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x000000003f2ff00=
0-0x000000003f2fffff] usable
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x000000003f30000=
0-0x000000003f3fffff] reserved
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x00000000e000000=
0-0x00000000efffffff] reserved
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x00000000fe00000=
0-0x00000000fe010fff] reserved
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x00000000fec0000=
0-0x00000000fec00fff] reserved
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x00000000fee0000=
0-0x00000000fee00fff] reserved
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x00000000ff00000=
0-0x00000000ffffffff] reserved
Nov 15 12:05:19 deepblue kernel: reserve setup_data: [mem 0x000000010000000=
0-0x000000047effffff] usable
Nov 15 12:05:19 deepblue kernel: efi: EFI v2.40 by American Megatrends
Nov 15 12:05:19 deepblue kernel: efi:  ACPI=3D0x3e51e000  ACPI 2.0=3D0x3e51=
e000  SMBIOS=3D0x3f1c2000  SMBIOS 3.0=3D0x3f1c1000  ESRT=3D0x3f1c3b18 =

Nov 15 12:05:19 deepblue kernel: SMBIOS 3.0.0 present.
Nov 15 12:05:19 deepblue kernel: DMI:  /NUC6i5SYB, BIOS SYSKLi35.86A.0073.2=
020.0909.1625 09/09/2020
Nov 15 12:05:19 deepblue kernel: tsc: Detected 1800.000 MHz processor
Nov 15 12:05:19 deepblue kernel: e820: update [mem 0x00000000-0x00000fff] u=
sable =3D=3D> reserved
Nov 15 12:05:19 deepblue kernel: e820: remove [mem 0x000a0000-0x000fffff] u=
sable
Nov 15 12:05:19 deepblue kernel: last_pfn =3D 0x47f000 max_arch_pfn =3D 0x4=
00000000
Nov 15 12:05:19 deepblue kernel: MTRR default type: write-back
Nov 15 12:05:19 deepblue kernel: MTRR fixed ranges enabled:
Nov 15 12:05:19 deepblue kernel:   00000-9FFFF write-back
Nov 15 12:05:19 deepblue kernel:   A0000-BFFFF uncachable
Nov 15 12:05:19 deepblue kernel:   C0000-FFFFF write-protect
Nov 15 12:05:19 deepblue kernel: MTRR variable ranges enabled:
Nov 15 12:05:19 deepblue kernel:   0 base 0080000000 mask 7F80000000 uncach=
able
Nov 15 12:05:19 deepblue kernel:   1 base 0040000000 mask 7FC0000000 uncach=
able
Nov 15 12:05:19 deepblue kernel:   2 base 003F800000 mask 7FFF800000 uncach=
able
Nov 15 12:05:19 deepblue kernel:   3 disabled
Nov 15 12:05:19 deepblue kernel:   4 disabled
Nov 15 12:05:19 deepblue kernel:   5 disabled
Nov 15 12:05:19 deepblue kernel:   6 disabled
Nov 15 12:05:19 deepblue kernel:   7 disabled
Nov 15 12:05:19 deepblue kernel:   8 disabled
Nov 15 12:05:19 deepblue kernel:   9 disabled
Nov 15 12:05:19 deepblue kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- =
UC  WB  WP  UC- WT  =

Nov 15 12:05:19 deepblue kernel: last_pfn =3D 0x3f300 max_arch_pfn =3D 0x40=
0000000
Nov 15 12:05:19 deepblue kernel: esrt: Reserving ESRT space from 0x00000000=
3f1c3b18 to 0x000000003f1c3b50.
Nov 15 12:05:19 deepblue kernel: check: Scanning 1 areas for low memory cor=
ruption
Nov 15 12:05:19 deepblue kernel: Using GB pages for direct mapping
Nov 15 12:05:19 deepblue kernel: Secure boot disabled
Nov 15 12:05:19 deepblue kernel: RAMDISK: [mem 0x33408000-0x33796fff]
Nov 15 12:05:19 deepblue kernel: ACPI: Early table checksum verification di=
sabled
Nov 15 12:05:19 deepblue kernel: ACPI: RSDP 0x000000003E51E000 000024 (v02 =
INTEL )
Nov 15 12:05:19 deepblue kernel: ACPI: XSDT 0x000000003E51E0A0 0000BC (v01 =
INTEL  NUC6i5SY 00000049 AMI  00010013)
Nov 15 12:05:19 deepblue kernel: ACPI: FACP 0x000000003E53FF00 00010C (v05 =
INTEL  NUC6i5SY 00000049 AMI  00010013)
Nov 15 12:05:19 deepblue kernel: ACPI: DSDT 0x000000003E51E1E8 021D12 (v02 =
INTEL  NUC6i5SY 00000049 INTL 20120913)
Nov 15 12:05:19 deepblue kernel: ACPI: FACS 0x000000003EE3CF80 000040
Nov 15 12:05:19 deepblue kernel: ACPI: APIC 0x000000003E540010 000084 (v03 =
INTEL  NUC6i5SY 00000049 AMI  00010013)
Nov 15 12:05:19 deepblue kernel: ACPI: FPDT 0x000000003E540098 000044 (v01 =
INTEL  NUC6i5SY 00000049 AMI  00010013)
Nov 15 12:05:19 deepblue kernel: ACPI: FIDT 0x000000003E5400E0 00009C (v01 =
INTEL  NUC6i5SY 00000049 AMI  00010013)
Nov 15 12:05:19 deepblue kernel: ACPI: MCFG 0x000000003E540180 00003C (v01 =
INTEL  NUC6i5SY 00000049 MSFT 00000097)
Nov 15 12:05:19 deepblue kernel: ACPI: HPET 0x000000003E5401C0 000038 (v01 =
INTEL  NUC6i5SY 00000049 AMI. 0005000B)
Nov 15 12:05:19 deepblue kernel: ACPI: LPIT 0x000000003E5401F8 000094 (v01 =
INTEL  NUC6i5SY 00000049 MSFT 0000005F)
Nov 15 12:05:19 deepblue kernel: ACPI: SSDT 0x000000003E540290 000248 (v02 =
INTEL  NUC6i5SY 00000049 INTL 20120913)
Nov 15 12:05:19 deepblue kernel: ACPI: SSDT 0x000000003E5404D8 002BAE (v02 =
INTEL  NUC6i5SY 00000049 INTL 20120913)
Nov 15 12:05:19 deepblue kernel: ACPI: SSDT 0x000000003E543088 000BE3 (v02 =
INTEL  NUC6i5SY 00000049 INTL 20120913)
Nov 15 12:05:19 deepblue kernel: ACPI: SSDT 0x000000003E543C70 0004A3 (v02 =
INTEL  NUC6i5SY 00000049 INTL 20120913)
Nov 15 12:05:19 deepblue kernel: ACPI: DBGP 0x000000003E544118 000034 (v01 =
INTEL  NUC6i5SY 00000049 MSFT 0000005F)
Nov 15 12:05:19 deepblue kernel: ACPI: DBG2 0x000000003E544150 000054 (v00 =
INTEL  NUC6i5SY 00000049 MSFT 0000005F)
Nov 15 12:05:19 deepblue kernel: ACPI: SSDT 0x000000003E5441A8 00046E (v02 =
INTEL  NUC6i5SY 00000049 INTL 20120913)
Nov 15 12:05:19 deepblue kernel: ACPI: SSDT 0x000000003E544618 00546C (v02 =
INTEL  NUC6i5SY 00000049 INTL 20120913)
Nov 15 12:05:19 deepblue kernel: ACPI: UEFI 0x000000003E549A88 000042 (v01 =
INTEL  NUC6i5SY 00000049      00000000)
Nov 15 12:05:19 deepblue kernel: ACPI: SSDT 0x000000003E549AD0 000E73 (v02 =
INTEL  NUC6i5SY 00000049 INTL 20120913)
Nov 15 12:05:19 deepblue kernel: ACPI: BGRT 0x000000003E54A948 000038 (v01 =
INTEL  NUC6i5SY 00000049 AMI  00010013)
Nov 15 12:05:19 deepblue kernel: ACPI: DMAR 0x000000003E54A980 0000CC (v01 =
INTEL  NUC6i5SY 00000049 INTL 00000001)
Nov 15 12:05:19 deepblue kernel: ACPI: Local APIC address 0xfee00000
Nov 15 12:05:19 deepblue kernel: No NUMA configuration found
Nov 15 12:05:19 deepblue kernel: Faking a node at [mem 0x0000000000000000-0=
x000000047effffff]
Nov 15 12:05:19 deepblue kernel: NODE_DATA(0) allocated [mem 0x47effd000-0x=
47effffff]
Nov 15 12:05:19 deepblue kernel: Zone ranges:
Nov 15 12:05:19 deepblue kernel:   DMA      [mem 0x0000000000001000-0x00000=
00000ffffff]
Nov 15 12:05:19 deepblue kernel:   DMA32    [mem 0x0000000001000000-0x00000=
000ffffffff]
Nov 15 12:05:19 deepblue kernel:   Normal   [mem 0x0000000100000000-0x00000=
0047effffff]
Nov 15 12:05:19 deepblue kernel: Movable zone start for each node
Nov 15 12:05:19 deepblue kernel: Early memory node ranges
Nov 15 12:05:19 deepblue kernel:   node   0: [mem 0x0000000000001000-0x0000=
000000057fff]
Nov 15 12:05:19 deepblue kernel:   node   0: [mem 0x0000000000059000-0x0000=
00000009dfff]
Nov 15 12:05:19 deepblue kernel:   node   0: [mem 0x0000000000100000-0x0000=
000036bd0fff]
Nov 15 12:05:19 deepblue kernel:   node   0: [mem 0x0000000036bfc000-0x0000=
00003e20ffff]
Nov 15 12:05:19 deepblue kernel:   node   0: [mem 0x000000003f2ff000-0x0000=
00003f2fffff]
Nov 15 12:05:19 deepblue kernel:   node   0: [mem 0x0000000100000000-0x0000=
00047effffff]
Nov 15 12:05:19 deepblue kernel: Zeroed struct page in unavailable ranges: =
11902 pages
Nov 15 12:05:19 deepblue kernel: Initmem setup node 0 [mem 0x00000000000010=
00-0x000000047effffff]
Nov 15 12:05:19 deepblue kernel: On node 0 totalpages: 3920258
Nov 15 12:05:19 deepblue kernel:   DMA zone: 64 pages used for memmap
Nov 15 12:05:19 deepblue kernel:   DMA zone: 21 pages reserved
Nov 15 12:05:19 deepblue kernel:   DMA zone: 3996 pages, LIFO batch:0
Nov 15 12:05:19 deepblue kernel:   DMA32 zone: 3912 pages used for memmap
Nov 15 12:05:19 deepblue kernel:   DMA32 zone: 250342 pages, LIFO batch:63
Nov 15 12:05:19 deepblue kernel:   Normal zone: 57280 pages used for memmap
Nov 15 12:05:19 deepblue kernel:   Normal zone: 3665920 pages, LIFO batch:63
Nov 15 12:05:19 deepblue kernel: Reserving Intel graphics memory at [mem 0x=
40000000-0x7fffffff]
Nov 15 12:05:19 deepblue kernel: ACPI: PM-Timer IO Port: 0x1808
Nov 15 12:05:19 deepblue kernel: ACPI: Local APIC address 0xfee00000
Nov 15 12:05:19 deepblue kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge l=
int[0x1])
Nov 15 12:05:19 deepblue kernel: ACPI: LAPIC_NMI (acpi_id[0x02] high edge l=
int[0x1])
Nov 15 12:05:19 deepblue kernel: ACPI: LAPIC_NMI (acpi_id[0x03] high edge l=
int[0x1])
Nov 15 12:05:19 deepblue kernel: ACPI: LAPIC_NMI (acpi_id[0x04] high edge l=
int[0x1])
Nov 15 12:05:19 deepblue kernel: IOAPIC[0]: apic_id 2, version 32, address =
0xfec00000, GSI 0-119
Nov 15 12:05:19 deepblue kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_=
irq 2 dfl dfl)
Nov 15 12:05:19 deepblue kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_=
irq 9 high level)
Nov 15 12:05:19 deepblue kernel: ACPI: IRQ0 used by override.
Nov 15 12:05:19 deepblue kernel: ACPI: IRQ9 used by override.
Nov 15 12:05:19 deepblue kernel: Using ACPI (MADT) for SMP configuration in=
formation
Nov 15 12:05:19 deepblue kernel: ACPI: HPET id: 0x8086a701 base: 0xfed00000
Nov 15 12:05:19 deepblue kernel: e820: update [mem 0x3c690000-0x3c6f1fff] u=
sable =3D=3D> reserved
Nov 15 12:05:19 deepblue kernel: TSC deadline timer available
Nov 15 12:05:19 deepblue kernel: smpboot: Allowing 4 CPUs, 0 hotplug CPUs
Nov 15 12:05:19 deepblue kernel: [mem 0x80000000-0xdfffffff] available for =
PCI devices
Nov 15 12:05:19 deepblue kernel: clocksource: refined-jiffies: mask: 0xffff=
ffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
Nov 15 12:05:19 deepblue kernel: setup_percpu: NR_CPUS:320 nr_cpumask_bits:=
320 nr_cpu_ids:4 nr_node_ids:1
Nov 15 12:05:19 deepblue kernel: percpu: Embedded 52 pages/cpu s172952 r819=
2 d31848 u524288
Nov 15 12:05:19 deepblue kernel: pcpu-alloc: s172952 r8192 d31848 u524288 a=
lloc=3D1*2097152
Nov 15 12:05:19 deepblue kernel: pcpu-alloc: [0] 0 1 2 3 =

Nov 15 12:05:19 deepblue kernel: Built 1 zonelists, mobility grouping on.  =
Total pages: 3858981
Nov 15 12:05:19 deepblue kernel: Policy zone: Normal
Nov 15 12:05:19 deepblue kernel: Kernel command line: initrd=3D\intel-ucode=
.img root=3D/dev/sda2 rootfstype=3Dext4 rw quiet loglevel=3D2 mds=3Dfull
Nov 15 12:05:19 deepblue kernel: Dentry cache hash table entries: 2097152 (=
order: 12, 16777216 bytes, linear)
Nov 15 12:05:19 deepblue kernel: Inode-cache hash table entries: 1048576 (o=
rder: 11, 8388608 bytes, linear)
Nov 15 12:05:19 deepblue kernel: mem auto-init: stack:byref_all, heap alloc=
:on, heap free:off
Nov 15 12:05:19 deepblue kernel: Calgary: detecting Calgary via BIOS EBDA a=
rea
Nov 15 12:05:19 deepblue kernel: Calgary: Unable to locate Rio Grande table=
 in EBDA - bailing!
Nov 15 12:05:19 deepblue kernel: Memory: 15171016K/15681032K available (122=
91K kernel code, 1203K rwdata, 3020K rodata, 1160K init, 2248K bss, 510016K=
 reserved, 0K cma-reserved)
Nov 15 12:05:19 deepblue kernel: random: get_random_u64 called from __kmem_=
cache_create+0x3e/0x610 with crng_init=3D0
Nov 15 12:05:19 deepblue kernel: SLUB: HWalign=3D64, Order=3D0-3, MinObject=
s=3D0, CPUs=3D4, Nodes=3D1
Nov 15 12:05:19 deepblue kernel: Kernel/User page tables isolation: enabled
Nov 15 12:05:19 deepblue kernel: rcu: Preemptible hierarchical RCU implemen=
tation.
Nov 15 12:05:19 deepblue kernel: rcu:         RCU restricting CPUs from NR_=
CPUS=3D320 to nr_cpu_ids=3D4.
Nov 15 12:05:19 deepblue kernel:         Tasks RCU enabled.
Nov 15 12:05:19 deepblue kernel: rcu: RCU calculated value of scheduler-enl=
istment delay is 30 jiffies.
Nov 15 12:05:19 deepblue kernel: rcu: Adjusting geometry for rcu_fanout_lea=
f=3D16, nr_cpu_ids=3D4
Nov 15 12:05:19 deepblue kernel: NR_IRQS: 20736, nr_irqs: 1024, preallocate=
d irqs: 16
Nov 15 12:05:19 deepblue kernel: spurious 8259A interrupt: IRQ7.
Nov 15 12:05:19 deepblue kernel: Console: colour dummy device 160x64
Nov 15 12:05:19 deepblue kernel: printk: console [tty0] enabled
Nov 15 12:05:19 deepblue kernel: ACPI: Core revision 20190816
Nov 15 12:05:19 deepblue kernel: clocksource: hpet: mask: 0xffffffff max_cy=
cles: 0xffffffff, max_idle_ns: 79635855245 ns
Nov 15 12:05:19 deepblue kernel: APIC: Switch to symmetric I/O mode setup
Nov 15 12:05:19 deepblue kernel: DMAR: Host address width 39
Nov 15 12:05:19 deepblue kernel: DMAR: DRHD base: 0x000000fed90000 flags: 0=
x0
Nov 15 12:05:19 deepblue kernel: DMAR: dmar0: reg_base_addr fed90000 ver 1:=
0 cap 1c0000c40660462 ecap 7e3ff0505e
Nov 15 12:05:19 deepblue kernel: DMAR: DRHD base: 0x000000fed91000 flags: 0=
x1
Nov 15 12:05:19 deepblue kernel: DMAR: dmar1: reg_base_addr fed91000 ver 1:=
0 cap d2008c40660462 ecap f050da
Nov 15 12:05:19 deepblue kernel: DMAR: RMRR base: 0x0000003e2b3000 end: 0x0=
000003e2d2fff
Nov 15 12:05:19 deepblue kernel: DMAR: RMRR base: 0x0000003f800000 end: 0x0=
000007fffffff
Nov 15 12:05:19 deepblue kernel: DMAR: ANDD device: 9 name: \_SB.PCI0.UA00
Nov 15 12:05:19 deepblue kernel: DMAR-IR: IOAPIC id 2 under DRHD base  0xfe=
d91000 IOMMU 1
Nov 15 12:05:19 deepblue kernel: DMAR-IR: HPET id 0 under DRHD base 0xfed91=
000
Nov 15 12:05:19 deepblue kernel: DMAR-IR: Queued invalidation will be enabl=
ed to support x2apic and Intr-remapping.
Nov 15 12:05:19 deepblue kernel: DMAR-IR: Enabled IRQ remapping in x2apic m=
ode
Nov 15 12:05:19 deepblue kernel: x2apic enabled
Nov 15 12:05:19 deepblue kernel: Switched APIC routing to cluster x2apic.
Nov 15 12:05:19 deepblue kernel: ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 =
apic2=3D-1 pin2=3D-1
Nov 15 12:05:19 deepblue kernel: clocksource: tsc-early: mask: 0xffffffffff=
ffffff max_cycles: 0x19f2297dd97, max_idle_ns: 440795236593 ns
Nov 15 12:05:19 deepblue kernel: Calibrating delay loop (skipped), value ca=
lculated using timer frequency.. 3601.00 BogoMIPS (lpj=3D6000000)
Nov 15 12:05:19 deepblue kernel: pid_max: default: 32768 minimum: 301
Nov 15 12:05:19 deepblue kernel: LSM: Security Framework initializing
Nov 15 12:05:19 deepblue kernel: Yama: becoming mindful.
Nov 15 12:05:19 deepblue kernel: Mount-cache hash table entries: 32768 (ord=
er: 6, 262144 bytes, linear)
Nov 15 12:05:19 deepblue kernel: Mountpoint-cache hash table entries: 32768=
 (order: 6, 262144 bytes, linear)
Nov 15 12:05:19 deepblue kernel: *** VALIDATE tmpfs ***
Nov 15 12:05:19 deepblue kernel: *** VALIDATE proc ***
Nov 15 12:05:19 deepblue kernel: *** VALIDATE cgroup1 ***
Nov 15 12:05:19 deepblue kernel: *** VALIDATE cgroup2 ***
Nov 15 12:05:19 deepblue kernel: mce: CPU0: Thermal monitoring enabled (TM1)
Nov 15 12:05:19 deepblue kernel: process: using mwait in idle threads
Nov 15 12:05:19 deepblue kernel: Last level iTLB entries: 4KB 64, 2MB 8, 4M=
B 8
Nov 15 12:05:19 deepblue kernel: Last level dTLB entries: 4KB 64, 2MB 0, 4M=
B 0, 1GB 4
Nov 15 12:05:19 deepblue kernel: Spectre V1 : Mitigation: usercopy/swapgs b=
arriers and __user pointer sanitization
Nov 15 12:05:19 deepblue kernel: Spectre V2 : Mitigation: Full generic retp=
oline
Nov 15 12:05:19 deepblue kernel: Spectre V2 : Spectre v2 / SpectreRSB mitig=
ation: Filling RSB on context switch
Nov 15 12:05:19 deepblue kernel: Spectre V2 : Enabling Restricted Speculati=
on for firmware calls
Nov 15 12:05:19 deepblue kernel: Spectre V2 : mitigation: Enabling conditio=
nal Indirect Branch Prediction Barrier
Nov 15 12:05:19 deepblue kernel: Spectre V2 : User space: Mitigation: STIBP=
 via seccomp and prctl
Nov 15 12:05:19 deepblue kernel: Speculative Store Bypass: Mitigation: Spec=
ulative Store Bypass disabled via prctl and seccomp
Nov 15 12:05:19 deepblue kernel: SRBDS: Mitigation: Microcode
Nov 15 12:05:19 deepblue kernel: MDS: Mitigation: Clear CPU buffers
Nov 15 12:05:19 deepblue kernel: Freeing SMP alternatives memory: 32K
Nov 15 12:05:19 deepblue kernel: smpboot: CPU0: Intel(R) Core(TM) i5-6260U =
CPU @ 1.80GHz (family: 0x6, model: 0x4e, stepping: 0x3)
Nov 15 12:05:19 deepblue kernel: Performance Events: PEBS fmt3+, Skylake ev=
ents, 32-deep LBR, full-width counters, Intel PMU driver.
Nov 15 12:05:19 deepblue kernel: ... version:                4
Nov 15 12:05:19 deepblue kernel: ... bit width:              48
Nov 15 12:05:19 deepblue kernel: ... generic registers:      4
Nov 15 12:05:19 deepblue kernel: ... value mask:             0000ffffffffff=
ff
Nov 15 12:05:19 deepblue kernel: ... max period:             00007fffffffff=
ff
Nov 15 12:05:19 deepblue kernel: ... fixed-purpose events:   3
Nov 15 12:05:19 deepblue kernel: ... event mask:             00000007000000=
0f
Nov 15 12:05:19 deepblue kernel: rcu: Hierarchical SRCU implementation.
Nov 15 12:05:19 deepblue kernel: smp: Bringing up secondary CPUs ...
Nov 15 12:05:19 deepblue kernel: x86: Booting SMP configuration:
Nov 15 12:05:19 deepblue kernel: .... node  #0, CPUs:      #1 #2
Nov 15 12:05:19 deepblue kernel: MDS CPU bug present and SMT on, data leak =
possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/md=
s.html for more details.
Nov 15 12:05:19 deepblue kernel:  #3
Nov 15 12:05:19 deepblue kernel: smp: Brought up 1 node, 4 CPUs
Nov 15 12:05:19 deepblue kernel: smpboot: Max logical packages: 1
Nov 15 12:05:19 deepblue kernel: smpboot: Total of 4 processors activated (=
14405.00 BogoMIPS)
Nov 15 12:05:19 deepblue kernel: devtmpfs: initialized
Nov 15 12:05:19 deepblue kernel: clocksource: jiffies: mask: 0xffffffff max=
_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
Nov 15 12:05:19 deepblue kernel: futex hash table entries: 1024 (order: 4, =
65536 bytes, linear)
Nov 15 12:05:19 deepblue kernel: pinctrl core: initialized pinctrl subsystem
Nov 15 12:05:19 deepblue kernel: NET: Registered protocol family 16
Nov 15 12:05:19 deepblue kernel: cpuidle: using governor ladder
Nov 15 12:05:19 deepblue kernel: cpuidle: using governor menu
Nov 15 12:05:19 deepblue kernel: ACPI FADT declares the system doesn't supp=
ort PCIe ASPM, so disable it
Nov 15 12:05:19 deepblue kernel: ACPI: bus type PCI registered
Nov 15 12:05:19 deepblue kernel: acpiphp: ACPI Hot Plug PCI Controller Driv=
er version: 0.5
Nov 15 12:05:19 deepblue kernel: PCI: MMCONFIG for domain 0000 [bus 00-ff] =
at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
Nov 15 12:05:19 deepblue kernel: PCI: MMCONFIG at [mem 0xe0000000-0xeffffff=
f] reserved in E820
Nov 15 12:05:19 deepblue kernel: PCI: Using configuration type 1 for base a=
ccess
Nov 15 12:05:19 deepblue kernel: ENERGY_PERF_BIAS: Set to 'normal', was 'pe=
rformance'
Nov 15 12:05:19 deepblue kernel: HugeTLB registered 1.00 GiB page size, pre=
-allocated 0 pages
Nov 15 12:05:19 deepblue kernel: HugeTLB registered 2.00 MiB page size, pre=
-allocated 0 pages
Nov 15 12:05:19 deepblue kernel: ACPI: Added _OSI(Module Device)
Nov 15 12:05:19 deepblue kernel: ACPI: Added _OSI(Processor Device)
Nov 15 12:05:19 deepblue kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
Nov 15 12:05:19 deepblue kernel: ACPI: Added _OSI(Processor Aggregator Devi=
ce)
Nov 15 12:05:19 deepblue kernel: ACPI: Added _OSI(Linux-Dell-Video)
Nov 15 12:05:19 deepblue kernel: ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audi=
o)
Nov 15 12:05:19 deepblue kernel: ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
Nov 15 12:05:19 deepblue kernel: ACPI: 8 ACPI AML tables successfully acqui=
red and loaded
Nov 15 12:05:19 deepblue kernel: ACPI: [Firmware Bug]: BIOS _OSI(Linux) que=
ry ignored
Nov 15 12:05:19 deepblue kernel: ACPI: Dynamic OEM Table Load:
Nov 15 12:05:19 deepblue kernel: ACPI: SSDT 0xFFFF9D01ED701000 000558 (v02 =
PmRef  Cpu0Ist  00003000 INTL 20120913)
Nov 15 12:05:19 deepblue kernel: ACPI: \_PR_.CPU0: _OSC native thermal LVT =
Acked
Nov 15 12:05:19 deepblue kernel: ACPI: Dynamic OEM Table Load:
Nov 15 12:05:19 deepblue kernel: ACPI: SSDT 0xFFFF9D01ED6FA400 00037F (v02 =
PmRef  Cpu0Cst  00003001 INTL 20120913)
Nov 15 12:05:19 deepblue kernel: ACPI: Dynamic OEM Table Load:
Nov 15 12:05:19 deepblue kernel: ACPI: SSDT 0xFFFF9D01ED018840 00008E (v02 =
PmRef  Cpu0Hwp  00003000 INTL 20120913)
Nov 15 12:05:19 deepblue kernel: ACPI: Dynamic OEM Table Load:
Nov 15 12:05:19 deepblue kernel: ACPI: SSDT 0xFFFF9D01ED2D5000 000130 (v02 =
PmRef  HwpLvt   00003000 INTL 20120913)
Nov 15 12:05:19 deepblue kernel: ACPI: Dynamic OEM Table Load:
Nov 15 12:05:19 deepblue kernel: ACPI: SSDT 0xFFFF9D01ED702000 0005AA (v02 =
PmRef  ApIst    00003000 INTL 20120913)
Nov 15 12:05:19 deepblue kernel: ACPI: Dynamic OEM Table Load:
Nov 15 12:05:19 deepblue kernel: ACPI: SSDT 0xFFFF9D01ED2D5600 000119 (v02 =
PmRef  ApHwp    00003000 INTL 20120913)
Nov 15 12:05:19 deepblue kernel: ACPI: Dynamic OEM Table Load:
Nov 15 12:05:19 deepblue kernel: ACPI: SSDT 0xFFFF9D01ED2D5200 000119 (v02 =
PmRef  ApCst    00003000 INTL 20120913)
Nov 15 12:05:19 deepblue kernel: ACPI: Interpreter enabled
Nov 15 12:05:19 deepblue kernel: ACPI: (supports S0 S5)
Nov 15 12:05:19 deepblue kernel: ACPI: Using IOAPIC for interrupt routing
Nov 15 12:05:19 deepblue kernel: PCI: Using host bridge windows from ACPI; =
if necessary, use "pci=3Dnocrs" and report a bug
Nov 15 12:05:19 deepblue kernel: ACPI: Enabled 7 GPEs in block 00 to 7F
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [PG00] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [PG01] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [PG02] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [WRST] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [WRST] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [WRST] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [WRST] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [WRST] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [WRST] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [WRST] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [WRST] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [WRST] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [WRST] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [WRST] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [WRST] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [WRST] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [WRST] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [WRST] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [WRST] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [WRST] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [WRST] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [WRST] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [WRST] (on)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [FN00] (off)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [FN01] (off)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [FN02] (off)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [FN03] (off)
Nov 15 12:05:19 deepblue kernel: ACPI: Power Resource [FN04] (off)
Nov 15 12:05:19 deepblue kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 =
[bus 00-fe])
Nov 15 12:05:19 deepblue kernel: acpi PNP0A08:00: _OSC: OS supports [Extend=
edConfig ASPM ClockPM Segments MSI HPX-Type3]
Nov 15 12:05:19 deepblue kernel: acpi PNP0A08:00: _OSC failed (AE_ERROR); d=
isabling ASPM
Nov 15 12:05:19 deepblue kernel: PCI host bridge to bus 0000:00
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: root bus resource [io  0x=
0000-0x0cf7 window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: root bus resource [io  0x=
0d00-0xffff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: root bus resource [mem 0x=
000a0000-0x000bffff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: root bus resource [mem 0x=
000c0000-0x000c3fff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: root bus resource [mem 0x=
000c4000-0x000c7fff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: root bus resource [mem 0x=
000c8000-0x000cbfff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: root bus resource [mem 0x=
000cc000-0x000cffff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: root bus resource [mem 0x=
000d0000-0x000d3fff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: root bus resource [mem 0x=
000d4000-0x000d7fff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: root bus resource [mem 0x=
000d8000-0x000dbfff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: root bus resource [mem 0x=
000dc000-0x000dffff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: root bus resource [mem 0x=
000e0000-0x000e3fff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: root bus resource [mem 0x=
000e4000-0x000e7fff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: root bus resource [mem 0x=
000e8000-0x000ebfff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: root bus resource [mem 0x=
000ec000-0x000effff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: root bus resource [mem 0x=
80000000-0xdfffffff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: root bus resource [mem 0x=
fd000000-0xfe7fffff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: root bus resource [bus 00=
-fe]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:00.0: [8086:1904] type 00 clas=
s 0x060000
Nov 15 12:05:19 deepblue kernel: pci 0000:00:02.0: [8086:1926] type 00 clas=
s 0x030000
Nov 15 12:05:19 deepblue kernel: pci 0000:00:02.0: reg 0x10: [mem 0xde00000=
0-0xdeffffff 64bit]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:02.0: reg 0x18: [mem 0x8000000=
0-0xbfffffff 64bit pref]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:02.0: reg 0x20: [io  0xf000-0x=
f03f]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:02.0: BAR 2: assigned to efifb
Nov 15 12:05:19 deepblue kernel: pci 0000:00:14.0: [8086:9d2f] type 00 clas=
s 0x0c0330
Nov 15 12:05:19 deepblue kernel: pci 0000:00:14.0: reg 0x10: [mem 0xdf13000=
0-0xdf13ffff 64bit]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:14.0: PME# supported from D3ho=
t D3cold
Nov 15 12:05:19 deepblue kernel: pci 0000:00:14.2: [8086:9d31] type 00 clas=
s 0x118000
Nov 15 12:05:19 deepblue kernel: pci 0000:00:14.2: reg 0x10: [mem 0xdf15000=
0-0xdf150fff 64bit]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:16.0: [8086:9d3a] type 00 clas=
s 0x078000
Nov 15 12:05:19 deepblue kernel: pci 0000:00:16.0: reg 0x10: [mem 0xdf14f00=
0-0xdf14ffff 64bit]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:16.0: PME# supported from D3hot
Nov 15 12:05:19 deepblue kernel: pci 0000:00:17.0: [8086:9d03] type 00 clas=
s 0x010601
Nov 15 12:05:19 deepblue kernel: pci 0000:00:17.0: reg 0x10: [mem 0xdf14800=
0-0xdf149fff]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:17.0: reg 0x14: [mem 0xdf14e00=
0-0xdf14e0ff]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:17.0: reg 0x18: [io  0xf090-0x=
f097]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:17.0: reg 0x1c: [io  0xf080-0x=
f083]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:17.0: reg 0x20: [io  0xf060-0x=
f07f]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:17.0: reg 0x24: [mem 0xdf14d00=
0-0xdf14d7ff]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:17.0: PME# supported from D3hot
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1c.0: [8086:9d14] type 01 clas=
s 0x060400
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1c.0: PME# supported from D0 D=
3hot D3cold
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1e.0: [8086:9d27] type 00 clas=
s 0x118000
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1e.0: reg 0x10: [mem 0xdf14c00=
0-0xdf14cfff 64bit]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1e.6: [8086:9d2d] type 00 clas=
s 0x080501
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1e.6: reg 0x10: [mem 0xdf14b00=
0-0xdf14bfff 64bit]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1f.0: [8086:9d48] type 00 clas=
s 0x060100
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1f.2: [8086:9d21] type 00 clas=
s 0x058000
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1f.2: reg 0x10: [mem 0xdf14400=
0-0xdf147fff]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1f.3: [8086:9d70] type 00 clas=
s 0x040300
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1f.3: reg 0x10: [mem 0xdf14000=
0-0xdf143fff 64bit]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1f.3: reg 0x20: [mem 0xdf12000=
0-0xdf12ffff 64bit]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1f.3: PME# supported from D3ho=
t D3cold
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1f.4: [8086:9d23] type 00 clas=
s 0x0c0500
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1f.4: reg 0x10: [mem 0xdf14a00=
0-0xdf14a0ff 64bit]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1f.4: reg 0x20: [io  0xf040-0x=
f05f]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1f.6: [8086:1570] type 00 clas=
s 0x020000
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1f.6: reg 0x10: [mem 0xdf10000=
0-0xdf11ffff]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1f.6: PME# supported from D0 D=
3hot D3cold
Nov 15 12:05:19 deepblue kernel: pci 0000:01:00.0: [8086:24f3] type 00 clas=
s 0x028000
Nov 15 12:05:19 deepblue kernel: pci 0000:01:00.0: reg 0x10: [mem 0xdf00000=
0-0xdf001fff 64bit]
Nov 15 12:05:19 deepblue kernel: pci 0000:01:00.0: PME# supported from D0 D=
3hot D3cold
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1c.0: PCI bridge to [bus 01]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1c.0:   bridge window [mem 0xd=
f000000-0xdf0fffff]
Nov 15 12:05:19 deepblue kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 =
5 6 10 *11 12 14 15)
Nov 15 12:05:19 deepblue kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 =
5 6 *10 11 12 14 15)
Nov 15 12:05:19 deepblue kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 =
5 6 10 *11 12 14 15)
Nov 15 12:05:19 deepblue kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 =
5 6 10 *11 12 14 15)
Nov 15 12:05:19 deepblue kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 =
5 6 10 *11 12 14 15)
Nov 15 12:05:19 deepblue kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 =
5 6 10 *11 12 14 15)
Nov 15 12:05:19 deepblue kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 =
5 6 10 *11 12 14 15)
Nov 15 12:05:19 deepblue kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 =
5 6 10 *11 12 14 15)
Nov 15 12:05:19 deepblue kernel: iommu: Default domain type: Translated =

Nov 15 12:05:19 deepblue kernel: pci 0000:00:02.0: vgaarb: setting as boot =
VGA device
Nov 15 12:05:19 deepblue kernel: pci 0000:00:02.0: vgaarb: VGA device added=
: decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
Nov 15 12:05:19 deepblue kernel: pci 0000:00:02.0: vgaarb: bridge control p=
ossible
Nov 15 12:05:19 deepblue kernel: vgaarb: loaded
Nov 15 12:05:19 deepblue kernel: SCSI subsystem initialized
Nov 15 12:05:19 deepblue kernel: libata version 3.00 loaded.
Nov 15 12:05:19 deepblue kernel: ACPI: bus type USB registered
Nov 15 12:05:19 deepblue kernel: usbcore: registered new interface driver u=
sbfs
Nov 15 12:05:19 deepblue kernel: usbcore: registered new interface driver h=
ub
Nov 15 12:05:19 deepblue kernel: usbcore: registered new device driver usb
Nov 15 12:05:19 deepblue kernel: pps_core: LinuxPPS API ver. 1 registered
Nov 15 12:05:19 deepblue kernel: pps_core: Software ver. 5.3.6 - Copyright =
2005-2007 Rodolfo Giometti <giometti@linux.it>
Nov 15 12:05:19 deepblue kernel: PTP clock support registered
Nov 15 12:05:19 deepblue kernel: EDAC MC: Ver: 3.0.0
Nov 15 12:05:19 deepblue kernel: Registered efivars operations
Nov 15 12:05:19 deepblue kernel: PCI: Using ACPI for IRQ routing
Nov 15 12:05:19 deepblue kernel: PCI: pci_cache_line_size set to 64 bytes
Nov 15 12:05:19 deepblue kernel: e820: reserve RAM buffer [mem 0x00058000-0=
x0005ffff]
Nov 15 12:05:19 deepblue kernel: e820: reserve RAM buffer [mem 0x0009e000-0=
x0009ffff]
Nov 15 12:05:19 deepblue kernel: e820: reserve RAM buffer [mem 0x333f7018-0=
x33ffffff]
Nov 15 12:05:19 deepblue kernel: e820: reserve RAM buffer [mem 0x36bd1000-0=
x37ffffff]
Nov 15 12:05:19 deepblue kernel: e820: reserve RAM buffer [mem 0x3c690000-0=
x3fffffff]
Nov 15 12:05:19 deepblue kernel: e820: reserve RAM buffer [mem 0x3e210000-0=
x3fffffff]
Nov 15 12:05:19 deepblue kernel: e820: reserve RAM buffer [mem 0x3f300000-0=
x3fffffff]
Nov 15 12:05:19 deepblue kernel: e820: reserve RAM buffer [mem 0x47f000000-=
0x47fffffff]
Nov 15 12:05:19 deepblue kernel: NetLabel: Initializing
Nov 15 12:05:19 deepblue kernel: NetLabel:  domain hash size =3D 128
Nov 15 12:05:19 deepblue kernel: NetLabel:  protocols =3D UNLABELED CIPSOv4=
 CALIPSO
Nov 15 12:05:19 deepblue kernel: NetLabel:  unlabeled traffic allowed by de=
fault
Nov 15 12:05:19 deepblue kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0=
, 0, 0, 0, 0
Nov 15 12:05:19 deepblue kernel: hpet0: 8 comparators, 64-bit 24.000000 MHz=
 counter
Nov 15 12:05:19 deepblue kernel: clocksource: Switched to clocksource tsc-e=
arly
Nov 15 12:05:19 deepblue kernel: *** VALIDATE bpf ***
Nov 15 12:05:19 deepblue kernel: VFS: Disk quotas dquot_6.6.0
Nov 15 12:05:19 deepblue kernel: VFS: Dquot-cache hash table entries: 512 (=
order 0, 4096 bytes)
Nov 15 12:05:19 deepblue kernel: FS-Cache: Loaded
Nov 15 12:05:19 deepblue kernel: *** VALIDATE ramfs ***
Nov 15 12:05:19 deepblue kernel: *** VALIDATE hugetlbfs ***
Nov 15 12:05:19 deepblue kernel: pnp: PnP ACPI init
Nov 15 12:05:19 deepblue kernel: system 00:00: [io  0x0a00-0x0a2f] has been=
 reserved
Nov 15 12:05:19 deepblue kernel: system 00:00: [io  0x0a30-0x0a3f] has been=
 reserved
Nov 15 12:05:19 deepblue kernel: system 00:00: [io  0x0a40-0x0a4f] has been=
 reserved
Nov 15 12:05:19 deepblue kernel: system 00:00: Plug and Play ACPI device, I=
Ds PNP0c02 (active)
Nov 15 12:05:19 deepblue kernel: pnp 00:01: [dma 0 disabled]
Nov 15 12:05:19 deepblue kernel: pnp 00:01: Plug and Play ACPI device, IDs =
ITE8713 (active)
Nov 15 12:05:19 deepblue kernel: system 00:02: [io  0x0680-0x069f] has been=
 reserved
Nov 15 12:05:19 deepblue kernel: system 00:02: [io  0xffff] has been reserv=
ed
Nov 15 12:05:19 deepblue kernel: system 00:02: [io  0xffff] has been reserv=
ed
Nov 15 12:05:19 deepblue kernel: system 00:02: [io  0xffff] has been reserv=
ed
Nov 15 12:05:19 deepblue kernel: system 00:02: [io  0x1800-0x18fe] has been=
 reserved
Nov 15 12:05:19 deepblue kernel: system 00:02: [io  0x164e-0x164f] has been=
 reserved
Nov 15 12:05:19 deepblue kernel: system 00:02: Plug and Play ACPI device, I=
Ds PNP0c02 (active)
Nov 15 12:05:19 deepblue kernel: pnp 00:03: Plug and Play ACPI device, IDs =
PNP0b00 (active)
Nov 15 12:05:19 deepblue kernel: system 00:04: [io  0x1854-0x1857] has been=
 reserved
Nov 15 12:05:19 deepblue kernel: system 00:04: Plug and Play ACPI device, I=
Ds INT3f0d PNP0c02 (active)
Nov 15 12:05:19 deepblue kernel: system 00:05: [mem 0xfed10000-0xfed17fff] =
has been reserved
Nov 15 12:05:19 deepblue kernel: system 00:05: [mem 0xfed18000-0xfed18fff] =
has been reserved
Nov 15 12:05:19 deepblue kernel: system 00:05: [mem 0xfed19000-0xfed19fff] =
has been reserved
Nov 15 12:05:19 deepblue kernel: system 00:05: [mem 0xe0000000-0xefffffff] =
has been reserved
Nov 15 12:05:19 deepblue kernel: system 00:05: [mem 0xfed20000-0xfed3ffff] =
has been reserved
Nov 15 12:05:19 deepblue kernel: system 00:05: [mem 0xfed90000-0xfed93fff] =
could not be reserved
Nov 15 12:05:19 deepblue kernel: system 00:05: [mem 0xfed45000-0xfed8ffff] =
has been reserved
Nov 15 12:05:19 deepblue kernel: system 00:05: [mem 0xff000000-0xffffffff] =
has been reserved
Nov 15 12:05:19 deepblue kernel: system 00:05: [mem 0xfee00000-0xfeefffff] =
could not be reserved
Nov 15 12:05:19 deepblue kernel: system 00:05: [mem 0xdffe0000-0xdfffffff] =
has been reserved
Nov 15 12:05:19 deepblue kernel: system 00:05: Plug and Play ACPI device, I=
Ds PNP0c02 (active)
Nov 15 12:05:19 deepblue kernel: system 00:06: [mem 0xfd000000-0xfdabffff] =
has been reserved
Nov 15 12:05:19 deepblue kernel: system 00:06: [mem 0xfdad0000-0xfdadffff] =
has been reserved
Nov 15 12:05:19 deepblue kernel: system 00:06: [mem 0xfdb00000-0xfdffffff] =
has been reserved
Nov 15 12:05:19 deepblue kernel: system 00:06: [mem 0xfe000000-0xfe01ffff] =
could not be reserved
Nov 15 12:05:19 deepblue kernel: system 00:06: [mem 0xfe036000-0xfe03bfff] =
has been reserved
Nov 15 12:05:19 deepblue kernel: system 00:06: [mem 0xfe03d000-0xfe3fffff] =
has been reserved
Nov 15 12:05:19 deepblue kernel: system 00:06: [mem 0xfe410000-0xfe7fffff] =
has been reserved
Nov 15 12:05:19 deepblue kernel: system 00:06: Plug and Play ACPI device, I=
Ds PNP0c02 (active)
Nov 15 12:05:19 deepblue kernel: system 00:07: [io  0xff00-0xfffe] has been=
 reserved
Nov 15 12:05:19 deepblue kernel: system 00:07: Plug and Play ACPI device, I=
Ds PNP0c02 (active)
Nov 15 12:05:19 deepblue kernel: system 00:08: [mem 0xfe029000-0xfe029fff] =
has been reserved
Nov 15 12:05:19 deepblue kernel: system 00:08: [mem 0xfe028000-0xfe028fff] =
has been reserved
Nov 15 12:05:19 deepblue kernel: system 00:08: Plug and Play ACPI device, I=
Ds PNP0c02 (active)
Nov 15 12:05:19 deepblue kernel: pnp: PnP ACPI: found 9 devices
Nov 15 12:05:19 deepblue kernel: thermal_sys: Registered thermal governor '=
fair_share'
Nov 15 12:05:19 deepblue kernel: thermal_sys: Registered thermal governor '=
bang_bang'
Nov 15 12:05:19 deepblue kernel: thermal_sys: Registered thermal governor '=
step_wise'
Nov 15 12:05:19 deepblue kernel: thermal_sys: Registered thermal governor '=
user_space'
Nov 15 12:05:19 deepblue kernel: thermal_sys: Registered thermal governor '=
power_allocator'
Nov 15 12:05:19 deepblue kernel: clocksource: acpi_pm: mask: 0xffffff max_c=
ycles: 0xffffff, max_idle_ns: 2085701024 ns
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1c.0: PCI bridge to [bus 01]
Nov 15 12:05:19 deepblue kernel: pci 0000:00:1c.0:   bridge window [mem 0xd=
f000000-0xdf0fffff]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x=
0cf7 window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: resource 5 [io  0x0d00-0x=
ffff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: resource 6 [mem 0x000a000=
0-0x000bffff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: resource 7 [mem 0x000c000=
0-0x000c3fff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: resource 8 [mem 0x000c400=
0-0x000c7fff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: resource 9 [mem 0x000c800=
0-0x000cbfff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: resource 10 [mem 0x000cc0=
00-0x000cffff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: resource 11 [mem 0x000d00=
00-0x000d3fff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: resource 12 [mem 0x000d40=
00-0x000d7fff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: resource 13 [mem 0x000d80=
00-0x000dbfff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: resource 14 [mem 0x000dc0=
00-0x000dffff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: resource 15 [mem 0x000e00=
00-0x000e3fff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: resource 16 [mem 0x000e40=
00-0x000e7fff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: resource 17 [mem 0x000e80=
00-0x000ebfff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: resource 18 [mem 0x000ec0=
00-0x000effff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: resource 19 [mem 0x800000=
00-0xdfffffff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:00: resource 20 [mem 0xfd0000=
00-0xfe7fffff window]
Nov 15 12:05:19 deepblue kernel: pci_bus 0000:01: resource 1 [mem 0xdf00000=
0-0xdf0fffff]
Nov 15 12:05:19 deepblue kernel: NET: Registered protocol family 2
Nov 15 12:05:19 deepblue kernel: tcp_listen_portaddr_hash hash table entrie=
s: 8192 (order: 5, 131072 bytes, linear)
Nov 15 12:05:19 deepblue kernel: TCP established hash table entries: 131072=
 (order: 8, 1048576 bytes, linear)
Nov 15 12:05:19 deepblue kernel: TCP bind hash table entries: 65536 (order:=
 8, 1048576 bytes, linear)
Nov 15 12:05:19 deepblue kernel: TCP: Hash tables configured (established 1=
31072 bind 65536)
Nov 15 12:05:19 deepblue kernel: UDP hash table entries: 8192 (order: 6, 26=
2144 bytes, linear)
Nov 15 12:05:19 deepblue kernel: UDP-Lite hash table entries: 8192 (order: =
6, 262144 bytes, linear)
Nov 15 12:05:19 deepblue kernel: NET: Registered protocol family 1
Nov 15 12:05:19 deepblue kernel: NET: Registered protocol family 44
Nov 15 12:05:19 deepblue kernel: pci 0000:00:02.0: Video device with shadow=
ed ROM at [mem 0x000c0000-0x000dffff]
Nov 15 12:05:19 deepblue kernel: PCI: CLS 0 bytes, default 64
Nov 15 12:05:19 deepblue kernel: Unpacking initramfs...
Nov 15 12:05:19 deepblue kernel: Freeing initrd memory: 3644K
Nov 15 12:05:19 deepblue kernel: DMAR: ACPI device "device:67" under DMAR a=
t fed91000 as 00:1e.0
Nov 15 12:05:19 deepblue kernel: PCI-DMA: Using software bounce buffering f=
or IO (SWIOTLB)
Nov 15 12:05:19 deepblue kernel: software IO TLB: mapped [mem 0x2f3f7000-0x=
333f7000] (64MB)
Nov 15 12:05:19 deepblue kernel: check: Scanning for low memory corruption =
every 60 seconds
Nov 15 12:05:19 deepblue kernel: Initialise system trusted keyrings
Nov 15 12:05:19 deepblue kernel: Key type blacklist registered
Nov 15 12:05:19 deepblue kernel: workingset: timestamp_bits=3D41 max_order=
=3D22 bucket_order=3D0
Nov 15 12:05:19 deepblue kernel: fuse: init (API version 7.31)
Nov 15 12:05:19 deepblue kernel: *** VALIDATE fuse ***
Nov 15 12:05:19 deepblue kernel: *** VALIDATE fuse ***
Nov 15 12:05:19 deepblue kernel: Key type asymmetric registered
Nov 15 12:05:19 deepblue kernel: Asymmetric key parser 'x509' registered
Nov 15 12:05:19 deepblue kernel: Block layer SCSI generic (bsg) driver vers=
ion 0.4 loaded (major 245)
Nov 15 12:05:19 deepblue kernel: io scheduler mq-deadline registered
Nov 15 12:05:19 deepblue kernel: io scheduler kyber registered
Nov 15 12:05:19 deepblue kernel: io scheduler bfq registered
Nov 15 12:05:19 deepblue kernel: shpchp: Standard Hot Plug PCI Controller D=
river version: 0.4
Nov 15 12:05:19 deepblue kernel: efifb: probing for efifb
Nov 15 12:05:19 deepblue kernel: efifb: framebuffer at 0x80000000, using 81=
00k, total 8100k
Nov 15 12:05:19 deepblue kernel: efifb: mode is 1920x1080x32, linelength=3D=
7680, pages=3D1
Nov 15 12:05:19 deepblue kernel: efifb: scrolling: redraw
Nov 15 12:05:19 deepblue kernel: efifb: Truecolor: size=3D8:8:8:8, shift=3D=
24:16:8:0
Nov 15 12:05:19 deepblue kernel: fbcon: Deferring console take-over
Nov 15 12:05:19 deepblue kernel: fb0: EFI VGA frame buffer device
Nov 15 12:05:19 deepblue kernel: intel_idle: MWAIT substates: 0x11142120
Nov 15 12:05:19 deepblue kernel: intel_idle: v0.4.1 model 0x4E
Nov 15 12:05:19 deepblue kernel: intel_idle: lapic_timer_reliable_states 0x=
ffffffff
Nov 15 12:05:19 deepblue kernel: input: Sleep Button as /devices/LNXSYSTM:0=
0/LNXSYBUS:00/PNP0C0E:00/input/input0
Nov 15 12:05:19 deepblue kernel: ACPI: Sleep Button [SLPB]
Nov 15 12:05:19 deepblue kernel: input: Power Button as /devices/LNXSYSTM:0=
0/LNXSYBUS:00/PNP0C0C:00/input/input1
Nov 15 12:05:19 deepblue kernel: ACPI: Power Button [PWRB]
Nov 15 12:05:19 deepblue kernel: input: Power Button as /devices/LNXSYSTM:0=
0/LNXPWRBN:00/input/input2
Nov 15 12:05:19 deepblue kernel: ACPI: Power Button [PWRF]
Nov 15 12:05:19 deepblue kernel: thermal LNXTHERM:00: registered as thermal=
_zone0
Nov 15 12:05:19 deepblue kernel: ACPI: Thermal Zone [TZ00] (28 C)
Nov 15 12:05:19 deepblue kernel: thermal LNXTHERM:01: registered as thermal=
_zone1
Nov 15 12:05:19 deepblue kernel: ACPI: Thermal Zone [TZ01] (30 C)
Nov 15 12:05:19 deepblue kernel: Linux agpgart interface v0.103
Nov 15 12:05:19 deepblue kernel: loop: module loaded
Nov 15 12:05:19 deepblue kernel: ahci 0000:00:17.0: version 3.0
Nov 15 12:05:19 deepblue kernel: ahci 0000:00:17.0: AHCI 0001.0301 32 slots=
 2 ports 6 Gbps 0x5 impl SATA mode
Nov 15 12:05:19 deepblue kernel: ahci 0000:00:17.0: flags: 64bit ncq pm led=
 clo only pio slum part deso sadm sds apst =

Nov 15 12:05:19 deepblue kernel: scsi host0: ahci
Nov 15 12:05:19 deepblue kernel: scsi host1: ahci
Nov 15 12:05:19 deepblue kernel: scsi host2: ahci
Nov 15 12:05:19 deepblue kernel: ata1: SATA max UDMA/133 abar m2048(a)0xdf1=
4d000 port 0xdf14d100 irq 123
Nov 15 12:05:19 deepblue kernel: ata2: DUMMY
Nov 15 12:05:19 deepblue kernel: ata3: SATA max UDMA/133 abar m2048(a)0xdf1=
4d000 port 0xdf14d200 irq 123
Nov 15 12:05:19 deepblue kernel: e1000e: Intel(R) PRO/1000 Network Driver -=
 3.2.6-k
Nov 15 12:05:19 deepblue kernel: e1000e: Copyright(c) 1999 - 2015 Intel Cor=
poration.
Nov 15 12:05:19 deepblue kernel: e1000e 0000:00:1f.6: enabling device (0000=
 -> 0002)
Nov 15 12:05:19 deepblue kernel: e1000e 0000:00:1f.6: Interrupt Throttling =
Rate (ints/sec) set to dynamic conservative mode
Nov 15 12:05:19 deepblue kernel: e1000e 0000:00:1f.6 0000:00:1f.6 (uninitia=
lized): registered PHC clock
Nov 15 12:05:19 deepblue kernel: ata1: SATA link down (SStatus 4 SControl 3=
00)
Nov 15 12:05:19 deepblue kernel: ata3: SATA link up 6.0 Gbps (SStatus 133 S=
Control 300)
Nov 15 12:05:19 deepblue kernel: ata3.00: supports DRM functions and may no=
t be fully accessible
Nov 15 12:05:19 deepblue kernel: ata3.00: disabling queued TRIM support
Nov 15 12:05:19 deepblue kernel: ata3.00: ATA-9: Samsung SSD 850 EVO M.2 12=
0GB, EMT21B6Q, max UDMA/133
Nov 15 12:05:19 deepblue kernel: ata3.00: 234441648 sectors, multi 1: LBA48=
 NCQ (depth 32), AA
Nov 15 12:05:19 deepblue kernel: ata3.00: supports DRM functions and may no=
t be fully accessible
Nov 15 12:05:19 deepblue kernel: ata3.00: disabling queued TRIM support
Nov 15 12:05:19 deepblue kernel: ata3.00: configured for UDMA/133
Nov 15 12:05:19 deepblue kernel: ahci 0000:00:17.0: port does not support d=
evice sleep
Nov 15 12:05:19 deepblue kernel: scsi 2:0:0:0: Direct-Access     ATA      S=
amsung SSD 850  1B6Q PQ: 0 ANSI: 5
Nov 15 12:05:19 deepblue kernel: e1000e 0000:00:1f.6 eth0: (PCI Express:2.5=
GT/s:Width x1) 94:c6:91:13:a0:64
Nov 15 12:05:19 deepblue kernel: e1000e 0000:00:1f.6 eth0: Intel(R) PRO/100=
0 Network Connection
Nov 15 12:05:19 deepblue kernel: e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12=
, PBA No: FFFFFF-0FF
Nov 15 12:05:19 deepblue kernel: usbcore: registered new interface driver u=
sb-storage
Nov 15 12:05:19 deepblue kernel: rtc_cmos 00:03: RTC can wake from S4
Nov 15 12:05:19 deepblue kernel: sd 2:0:0:0: [sda] 234441648 512-byte logic=
al blocks: (120 GB/112 GiB)
Nov 15 12:05:19 deepblue kernel: sd 2:0:0:0: [sda] Write Protect is off
Nov 15 12:05:19 deepblue kernel: sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
Nov 15 12:05:19 deepblue kernel: sd 2:0:0:0: [sda] Write cache: enabled, re=
ad cache: enabled, doesn't support DPO or FUA
Nov 15 12:05:19 deepblue kernel: rtc_cmos 00:03: registered as rtc0
Nov 15 12:05:19 deepblue kernel: rtc_cmos 00:03: alarms up to one month, y3=
k, 242 bytes nvram, hpet irqs
Nov 15 12:05:19 deepblue kernel: intel_pstate: Intel P-state driver initial=
izing
Nov 15 12:05:19 deepblue kernel: intel_pstate: HWP enabled
Nov 15 12:05:19 deepblue kernel: ledtrig-cpu: registered to indicate activi=
ty on CPUs
Nov 15 12:05:19 deepblue kernel: EFI Variables Facility v0.08 2004-May-17
Nov 15 12:05:19 deepblue kernel:  sda: sda1 sda2 sda3 sda4
Nov 15 12:05:19 deepblue kernel: sd 2:0:0:0: [sda] supports TCG Opal
Nov 15 12:05:19 deepblue kernel: sd 2:0:0:0: [sda] Attached SCSI disk
Nov 15 12:05:19 deepblue kernel: pstore: Registered efi as persistent store=
 backend
Nov 15 12:05:19 deepblue kernel: hidraw: raw HID events driver (C) Jiri Kos=
ina
Nov 15 12:05:19 deepblue kernel: intel_pmc_core INT33A1:00:  initialized
Nov 15 12:05:19 deepblue kernel: drop_monitor: Initializing network drop mo=
nitor service
Nov 15 12:05:19 deepblue kernel: NET: Registered protocol family 10
Nov 15 12:05:19 deepblue kernel: Segment Routing with IPv6
Nov 15 12:05:19 deepblue kernel: NET: Registered protocol family 17
Nov 15 12:05:19 deepblue kernel: RAS: Correctable Errors collector initiali=
zed.
Nov 15 12:05:19 deepblue kernel: microcode: sig=3D0x406e3, pf=3D0x40, revis=
ion=3D0xe2
Nov 15 12:05:19 deepblue kernel: microcode: Microcode Update Driver: v2.2.
Nov 15 12:05:19 deepblue kernel: IPI shorthand broadcast: enabled
Nov 15 12:05:19 deepblue kernel: sched_clock: Marking stable (1446879067, 7=
78240)->(1450673699, -3016392)
Nov 15 12:05:19 deepblue kernel: registered taskstats version 1
Nov 15 12:05:19 deepblue kernel: Loading compiled-in X.509 certificates
Nov 15 12:05:19 deepblue kernel: Key type ._fscrypt registered
Nov 15 12:05:19 deepblue kernel: Key type .fscrypt registered
Nov 15 12:05:19 deepblue kernel: pstore: Using crash dump compression: zstd
Nov 15 12:05:19 deepblue kernel: Key type big_key registered
Nov 15 12:05:19 deepblue kernel: rtc_cmos 00:03: setting system clock to 20=
20-11-15T11:05:18 UTC (1605438318)
Nov 15 12:05:19 deepblue kernel: EXT4-fs (sda2): mounted filesystem with or=
dered data mode. Opts: (null)
Nov 15 12:05:19 deepblue kernel: VFS: Mounted root (ext4 filesystem) on dev=
ice 8:2.
Nov 15 12:05:19 deepblue kernel: devtmpfs: mounted
Nov 15 12:05:19 deepblue kernel: Freeing unused kernel image memory: 1160K
Nov 15 12:05:19 deepblue kernel: Write protecting the kernel read-only data=
: 18432k
Nov 15 12:05:19 deepblue kernel: Freeing unused kernel image memory: 2012K
Nov 15 12:05:19 deepblue kernel: Freeing unused kernel image memory: 1076K
Nov 15 12:05:19 deepblue kernel: Run /sbin/init as init process
Nov 15 12:05:19 deepblue kernel: random: fast init done
Nov 15 12:05:19 deepblue kernel: fbcon: Taking over console
Nov 15 12:05:19 deepblue kernel: Console: switching to colour frame buffer =
device 240x67
Nov 15 12:05:19 deepblue kernel: EXT4-fs (sda2): re-mounted. Opts: data=3Do=
rdered,discard
Nov 15 12:05:19 deepblue kernel: Asymmetric key parser 'pkcs8' registered
Nov 15 12:05:19 deepblue kernel: random: lvm: uninitialized urandom read (4=
 bytes read)
Nov 15 12:05:19 deepblue kernel: tsc: Refined TSC clocksource calibration: =
1800.009 MHz
Nov 15 12:05:19 deepblue kernel: clocksource: tsc: mask: 0xffffffffffffffff=
 max_cycles: 0x19f23209bc1, max_idle_ns: 440795220317 ns
Nov 15 12:05:19 deepblue kernel: clocksource: Switched to clocksource tsc
Nov 15 12:05:19 deepblue systemd-journald[163]: Journal started
Nov 15 12:05:19 deepblue systemd-journald[163]: Runtime Journal (/run/log/j=
ournal/4f7eed55a8b348b2a766893165b69fe4) is 8.0M, max 192.0M, 184.0M free.
Nov 15 12:05:19 deepblue systemd-modules-load[164]: Inserted module 'pkcs8_=
key_parser'
Nov 15 12:05:19 deepblue systemd-sysctl[172]: Not setting net/ipv4/conf/all=
/rp_filter (explicit setting exists).
Nov 15 12:05:19 deepblue systemd-sysctl[172]: Not setting net/ipv4/conf/def=
ault/rp_filter (explicit setting exists).
Nov 15 12:05:19 deepblue systemd-sysctl[172]: Not setting net/ipv4/conf/all=
/accept_source_route (explicit setting exists).
Nov 15 12:05:19 deepblue systemd-sysctl[172]: Not setting net/ipv4/conf/def=
ault/accept_source_route (explicit setting exists).
Nov 15 12:05:19 deepblue systemd-sysctl[172]: Not setting net/ipv4/conf/all=
/promote_secondaries (explicit setting exists).
Nov 15 12:05:19 deepblue systemd-sysctl[172]: Not setting net/ipv4/conf/def=
ault/promote_secondaries (explicit setting exists).
Nov 15 12:05:19 deepblue systemd-random-seed[171]: Kernel entropy pool is n=
ot initialized yet, waiting until it is.
Nov 15 12:05:19 deepblue systemd-journald[163]: Runtime Journal (/run/log/j=
ournal/4f7eed55a8b348b2a766893165b69fe4) is 8.0M, max 192.0M, 184.0M free.
Nov 15 12:05:19 deepblue kernel: ite_cir: Auto-detected model: ITE8713 CIR =
transceiver
Nov 15 12:05:19 deepblue kernel: ite_cir: Using model: ITE8713 CIR transcei=
ver
Nov 15 12:05:19 deepblue kernel: ite_cir: TX-capable: 1
Nov 15 12:05:19 deepblue kernel: ite_cir: Sample period (ns): 8680
Nov 15 12:05:19 deepblue kernel: ite_cir: TX carrier frequency (Hz): 38000
Nov 15 12:05:19 deepblue kernel: ite_cir: TX duty cycle (%): 33
Nov 15 12:05:19 deepblue kernel: ite_cir: RX low carrier frequency (Hz): 0
Nov 15 12:05:19 deepblue kernel: ite_cir: RX high carrier frequency (Hz): 0
Nov 15 12:05:19 deepblue kernel: Registered IR keymap rc-rc6-mce
Nov 15 12:05:19 deepblue kernel: IR RC6 protocol handler initialized
Nov 15 12:05:19 deepblue systemd-udevd[189]: Using default interface naming=
 scheme 'v245'.
Nov 15 12:05:19 deepblue systemd-udevd[189]: ethtool: autonegotiation is un=
set or enabled, the speed and duplex are not writable.
Nov 15 12:05:19 deepblue kernel: e1000e 0000:00:1f.6 eno1: renamed from eth0
Nov 15 12:05:19 deepblue kernel: i801_smbus 0000:00:1f.4: SMBus using PCI i=
nterrupt
Nov 15 12:05:19 deepblue kernel: xhci_hcd 0000:00:14.0: xHCI Host Controller
Nov 15 12:05:19 deepblue kernel: xhci_hcd 0000:00:14.0: new USB bus registe=
red, assigned bus number 1
Nov 15 12:05:19 deepblue kernel: sdhci: Secure Digital Host Controller Inte=
rface driver
Nov 15 12:05:19 deepblue kernel: sdhci: Copyright(c) Pierre Ossman
Nov 15 12:05:19 deepblue kernel: xhci_hcd 0000:00:14.0: hcc params 0x200077=
c1 hci version 0x100 quirks 0x0000000081109810
Nov 15 12:05:19 deepblue kernel: xhci_hcd 0000:00:14.0: cache line size of =
64 is not supported
Nov 15 12:05:19 deepblue kernel: usb usb1: New USB device found, idVendor=
=3D1d6b, idProduct=3D0002, bcdDevice=3D 5.04
Nov 15 12:05:19 deepblue kernel: usb usb1: New USB device strings: Mfr=3D3,=
 Product=3D2, SerialNumber=3D1
Nov 15 12:05:19 deepblue kernel: usb usb1: Product: xHCI Host Controller
Nov 15 12:05:19 deepblue kernel: usb usb1: Manufacturer: Linux 5.4.63-a xhc=
i-hcd
Nov 15 12:05:19 deepblue kernel: usb usb1: SerialNumber: 0000:00:14.0
Nov 15 12:05:19 deepblue kernel: intel-lpss 0000:00:1e.0: enabling device (=
0000 -> 0002)
Nov 15 12:05:19 deepblue kernel: sdhci-pci 0000:00:1e.6: SDHCI controller f=
ound [8086:9d2d] (rev 21)
Nov 15 12:05:19 deepblue kernel: hub 1-0:1.0: USB hub found
Nov 15 12:05:19 deepblue kernel: hub 1-0:1.0: 12 ports detected
Nov 15 12:05:19 deepblue kernel: idma64 idma64.0: Found Intel integrated DM=
A 64-bit
Nov 15 12:05:19 deepblue kernel: rc rc0: ITE8713 CIR transceiver as /device=
s/virtual/rc/rc0
Nov 15 12:05:19 deepblue kernel: rc rc0: lirc_dev: driver ite-cir registere=
d at minor =3D 0, raw IR receiver, raw IR transmitter
Nov 15 12:05:19 deepblue kernel: input: ITE8713 CIR transceiver as /devices=
/virtual/rc/rc0/input3
Nov 15 12:05:19 deepblue kernel: ite_cir: driver has been successfully load=
ed
Nov 15 12:05:19 deepblue kernel: sdhci-pci 0000:00:1e.6: failed to setup ca=
rd detect gpio
Nov 15 12:05:19 deepblue kernel: xhci_hcd 0000:00:14.0: xHCI Host Controller
Nov 15 12:05:19 deepblue kernel: xhci_hcd 0000:00:14.0: new USB bus registe=
red, assigned bus number 2
Nov 15 12:05:19 deepblue kernel: xhci_hcd 0000:00:14.0: Host supports USB 3=
.0 SuperSpeed
Nov 15 12:05:19 deepblue kernel: usb usb2: New USB device found, idVendor=
=3D1d6b, idProduct=3D0003, bcdDevice=3D 5.04
Nov 15 12:05:19 deepblue kernel: usb usb2: New USB device strings: Mfr=3D3,=
 Product=3D2, SerialNumber=3D1
Nov 15 12:05:19 deepblue kernel: usb usb2: Product: xHCI Host Controller
Nov 15 12:05:19 deepblue kernel: usb usb2: Manufacturer: Linux 5.4.63-a xhc=
i-hcd
Nov 15 12:05:19 deepblue kernel: usb usb2: SerialNumber: 0000:00:14.0
Nov 15 12:05:19 deepblue kernel: cfg80211: Loading compiled-in X.509 certif=
icates for regulatory database
Nov 15 12:05:19 deepblue kernel: hub 2-0:1.0: USB hub found
Nov 15 12:05:19 deepblue kernel: hub 2-0:1.0: 6 ports detected
Nov 15 12:05:19 deepblue kernel: mei_me 0000:00:16.0: enabling device (0000=
 -> 0002)
Nov 15 12:05:19 deepblue kernel: input: PC Speaker as /devices/platform/pcs=
pkr/input/input4
Nov 15 12:05:19 deepblue kernel: mmc0: SDHCI controller on PCI [0000:00:1e.=
6] using ADMA 64-bit
Nov 15 12:05:19 deepblue kernel: RAPL PMU: API unit is 2^-32 Joules, 5 fixe=
d counters, 655360 ms ovfl timer
Nov 15 12:05:19 deepblue kernel: RAPL PMU: hw unit of domain pp0-core 2^-14=
 Joules
Nov 15 12:05:19 deepblue kernel: RAPL PMU: hw unit of domain package 2^-14 =
Joules
Nov 15 12:05:19 deepblue kernel: RAPL PMU: hw unit of domain dram 2^-14 Jou=
les
Nov 15 12:05:19 deepblue kernel: RAPL PMU: hw unit of domain pp1-gpu 2^-14 =
Joules
Nov 15 12:05:19 deepblue kernel: RAPL PMU: hw unit of domain psys 2^-14 Jou=
les
Nov 15 12:05:19 deepblue systemd-udevd[185]: ethtool: autonegotiation is un=
set or enabled, the speed and duplex are not writable.
Nov 15 12:05:19 deepblue kernel: cryptd: max_cpu_qlen set to 1000
Nov 15 12:05:19 deepblue kernel: AVX2 version of gcm_enc/dec engaged.
Nov 15 12:05:19 deepblue kernel: AES CTR mode by8 optimization enabled
Nov 15 12:05:19 deepblue kernel: snd_hda_intel 0000:00:1f.3: enabling devic=
e (0000 -> 0002)
Nov 15 12:05:19 deepblue systemd-udevd[204]: Using default interface naming=
 scheme 'v245'.
Nov 15 12:05:19 deepblue kernel: cfg80211: Loaded X.509 cert 'sforshee: 00b=
28ddf47aef9cea7'
Nov 15 12:05:19 deepblue kernel: iTCO_vendor_support: vendor-support=3D0
Nov 15 12:05:19 deepblue kernel: Setting dangerous option enable_guc - tain=
ting kernel
Nov 15 12:05:19 deepblue kernel: iTCO_wdt: Intel TCO WatchDog Timer Driver =
v1.11
Nov 15 12:05:19 deepblue kernel: iTCO_wdt: Found a Intel PCH TCO device (Ve=
rsion=3D4, TCOBASE=3D0x0400)
Nov 15 12:05:19 deepblue kernel: iTCO_wdt: initialized. heartbeat=3D30 sec =
(nowayout=3D0)
Nov 15 12:05:19 deepblue kernel: i915 0000:00:02.0: Found 64MB of eDRAM
Nov 15 12:05:19 deepblue kernel: checking generic (80000000 7e9000) vs hw (=
80000000 40000000)
Nov 15 12:05:19 deepblue kernel: fb0: switching to inteldrmfb from EFI VGA
Nov 15 12:05:19 deepblue kernel: Intel(R) Wireless WiFi driver for Linux
Nov 15 12:05:19 deepblue kernel: Copyright(c) 2003- 2015 Intel Corporation
Nov 15 12:05:19 deepblue kernel: iwlwifi 0000:01:00.0: enabling device (000=
0 -> 0002)
Nov 15 12:05:19 deepblue kernel: Console: switching to colour dummy device =
160x64
Nov 15 12:05:19 deepblue kernel: i915 0000:00:02.0: vgaarb: deactivate vga =
console
Nov 15 12:05:19 deepblue kernel: [drm] Supports vblank timestamp caching Re=
v 2 (21.10.2013).
Nov 15 12:05:19 deepblue kernel: [drm] Driver supports precise vblank times=
tamp query.
Nov 15 12:05:19 deepblue kernel: i915 0000:00:02.0: vgaarb: changed VGA dec=
odes: olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
Nov 15 12:05:19 deepblue kernel: [drm] Finished loading DMC firmware i915/s=
kl_dmc_ver1_27.bin (v1.27)
Nov 15 12:05:19 deepblue kernel: iwlwifi 0000:01:00.0: loaded firmware vers=
ion 36.ad812ee0.0 op_mode iwlmvm
Nov 15 12:05:19 deepblue kernel: iwlwifi 0000:01:00.0: Detected Intel(R) Du=
al Band Wireless AC 8260, REV=3D0x208
Nov 15 12:05:19 deepblue kernel: intel_rapl_common: Found RAPL domain packa=
ge
Nov 15 12:05:19 deepblue kernel: intel_rapl_common: Found RAPL domain core
Nov 15 12:05:19 deepblue kernel: intel_rapl_common: Found RAPL domain uncore
Nov 15 12:05:19 deepblue kernel: intel_rapl_common: Found RAPL domain dram
Nov 15 12:05:19 deepblue systemd-fsck[293]: /dev/sda3: sauber, 9097/3276800=
 Dateien, 6067548/13107200 Bl=C3=B6cke
Nov 15 12:05:19 deepblue kernel: iwlwifi 0000:01:00.0: base HW address: ac:=
ed:5c:f1:20:84
Nov 15 12:05:19 deepblue kernel: EXT4-fs (sda3): mounted filesystem with or=
dered data mode. Opts: data=3Dordered,discard
Nov 15 12:05:19 deepblue kernel: random: dbus-daemon: uninitialized urandom=
 read (12 bytes read)
Nov 15 12:05:19 deepblue kernel: random: dbus-daemon: uninitialized urandom=
 read (12 bytes read)
Nov 15 12:05:19 deepblue kernel: NET: Registered protocol family 38
Nov 15 12:05:19 deepblue kernel: ieee80211 phy0: Selected rate control algo=
rithm 'iwl-mvm-rs'
Nov 15 12:05:19 deepblue kernel: thermal thermal_zone4: failed to read out =
thermal zone (-61)
Nov 15 12:05:19 deepblue systemd-udevd[198]: Using default interface naming=
 scheme 'v245'.
Nov 15 12:05:19 deepblue systemd-udevd[198]: ethtool: autonegotiation is un=
set or enabled, the speed and duplex are not writable.
Nov 15 12:05:19 deepblue kernel: usb 1-4: new full-speed USB device number =
2 using xhci_hcd
Nov 15 12:05:19 deepblue kernel: alg: No test for hmac(md4) (hmac(md4-gener=
ic))
Nov 15 12:05:19 deepblue iwd[304]: Wireless daemon version 1.9
Nov 15 12:05:19 deepblue iwd[304]: src/main.c:main() Using configuration di=
rectory /etc/iwd
Nov 15 12:05:19 deepblue iwd[304]: Loaded configuration from /etc/iwd/main.=
conf
Nov 15 12:05:19 deepblue iwd[304]: src/storage.c:storage_create_dirs() Usin=
g state directory /var/lib/iwd
Nov 15 12:05:19 deepblue iwd[304]: src/main.c:nl80211_appeared() Found nl80=
211 interface
Nov 15 12:05:19 deepblue iwd[304]: src/module.c:iwd_modules_init()
Nov 15 12:05:19 deepblue iwd[304]: station: Network configuration is disabl=
ed.
Nov 15 12:05:19 deepblue iwd[304]: src/wsc.c:wsc_init()
Nov 15 12:05:19 deepblue iwd[304]: src/eap.c:__eap_method_enable()
Nov 15 12:05:19 deepblue iwd[304]: src/eap-wsc.c:eap_wsc_init()
Nov 15 12:05:19 deepblue iwd[304]: src/eap-md5.c:eap_md5_init()
Nov 15 12:05:19 deepblue iwd[304]: src/eap-tls.c:eap_tls_init()
Nov 15 12:05:19 deepblue iwd[304]: src/eap-ttls.c:eap_ttls_init()
Nov 15 12:05:19 deepblue iwd[304]: src/eap-mschapv2.c:eap_mschapv2_init()
Nov 15 12:05:19 deepblue iwd[304]: src/eap-sim.c:eap_sim_init()
Nov 15 12:05:19 deepblue iwd[304]: src/eap-aka.c:eap_aka_prime_init()
Nov 15 12:05:19 deepblue iwd[304]: src/eap-aka.c:eap_aka_init()
Nov 15 12:05:19 deepblue iwd[304]: src/eap-peap.c:eap_peap_init()
Nov 15 12:05:19 deepblue iwd[304]: src/eap-gtc.c:eap_gtc_init()
Nov 15 12:05:19 deepblue iwd[304]: src/eap-pwd.c:eap_pwd_init()
Nov 15 12:05:19 deepblue iwd[304]: src/manager.c:manager_wiphy_dump_callbac=
k() New wiphy phy0 added (0)
Nov 15 12:05:19 deepblue iwd[304]: Wiphy: 0, Name: phy0
Nov 15 12:05:19 deepblue iwd[304]:         Permanent Address: ac:ed:5c:f1:2=
0:84
Nov 15 12:05:19 deepblue iwd[304]:         Bands: 2.4 GHz 5 GHz
Nov 15 12:05:19 deepblue iwd[304]:         Ciphers: CCMP TKIP BIP
Nov 15 12:05:19 deepblue iwd[304]:         Supported iftypes: ad-hoc statio=
n ap p2p-client p2p-go p2p-device
Nov 15 12:05:19 deepblue iwd[304]: src/manager.c:manager_interface_dump_cal=
lback()
Nov 15 12:05:19 deepblue iwd[304]: src/manager.c:manager_get_interface_cb()
Nov 15 12:05:19 deepblue iwd[304]: src/manager.c:manager_get_interface_cb()
Nov 15 12:05:19 deepblue iwd[304]: src/wiphy.c:wiphy_update_reg_domain() Ne=
w reg domain country code for (global) is XX
Nov 15 12:05:19 deepblue kernel: ------------[ cut here ]------------
Nov 15 12:05:19 deepblue kernel: WARNING: CPU: 3 PID: 304 at net/wireless/n=
l80211.c:7029 nl80211_get_reg_do+0x228/0x290 [cfg80211]
Nov 15 12:05:19 deepblue kernel: Modules linked in: ccm algif_aead des_gene=
ric libdes algif_skcipher cmac md4 algif_hash af_alg intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul =
crc32_pclmul iwlmvm crc32c_intel mac80211 ghash_clmulni_intel libarc4 mei_h=
dcp iTCO_wdt intel_xhci_usb_role_switch iwlwifi roles iTCO_vendor_support i=
915(+) intel_gtt snd_hda_intel i2c_algo_bit aesni_intel glue_helper crypto_=
simd snd_intel_nhlt drm_kms_helper snd_hda_codec cryptd syscopyarea snd_hwd=
ep rapl sysfillrect intel_cstate snd_hda_core intel_uncore pcspkr snd_pcm s=
ysimgblt mei_me cfg80211 fb_sys_fops sdhci_pci mei intel_lpss_pci snd_timer=
 rfkill cqhci snd intel_lpss sdhci soundcore idma64 xhci_pci i2c_i801 mmc_c=
ore xhci_hcd virt_dma intel_pch_thermal ir_rc6_decoder rc_rc6_mce ite_cir r=
c_core evdev pkcs8_key_parser drm ip_tables x_tables
Nov 15 12:05:19 deepblue kernel: CPU: 3 PID: 304 Comm: iwd Tainted: G     U=
            5.4.63-a #1
Nov 15 12:05:19 deepblue kernel: Hardware name:  /NUC6i5SYB, BIOS SYSKLi35.=
86A.0073.2020.0909.1625 09/09/2020
Nov 15 12:05:19 deepblue kernel: RIP: 0010:nl80211_get_reg_do+0x228/0x290 [=
cfg80211]
Nov 15 12:05:19 deepblue kernel: Code: 89 ef c7 44 24 0c 01 00 00 00 e8 73 =
0f 2d d0 85 c0 74 cc e9 ff fe ff ff 48 89 ef 48 89 04 24 e8 6e de 57 d0 48 =
8b 04 24 eb 89 <0f> 0b 48 89 ef e8 5e de 57 d0 b8 ea ff ff ff e9 75 ff ff f=
f b8 97
Nov 15 12:05:19 deepblue kernel: RSP: 0018:ffffb0c30083fb68 EFLAGS: 00010202
Nov 15 12:05:19 deepblue kernel: RAX: 0000000000000000 RBX: 000000000000000=
1 RCX: 0000000000000000
Nov 15 12:05:19 deepblue kernel: RDX: ffff9d01e5b30008 RSI: 000000000000000=
0 RDI: ffff9d01e5b30300
Nov 15 12:05:19 deepblue kernel: RBP: ffff9d01e91fa500 R08: 000000000000001=
4 R09: ffff9d01e359b014
Nov 15 12:05:19 deepblue kernel: R10: 000000000000001d R11: ffffffffc05f0d1=
0 R12: ffffb0c30083fc30
Nov 15 12:05:19 deepblue kernel: R13: ffff9d01e359b014 R14: 000000000000000=
0 R15: ffff9d01e5b30300
Nov 15 12:05:19 deepblue kernel: FS:  00007f1f37e21740(0000) GS:ffff9d01efb=
80000(0000) knlGS:0000000000000000
Nov 15 12:05:19 deepblue kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
Nov 15 12:05:19 deepblue kernel: CR2: 00007ffe56518ca0 CR3: 000000046433c00=
3 CR4: 00000000003606e0
Nov 15 12:05:19 deepblue kernel: Call Trace:
Nov 15 12:05:19 deepblue kernel:  ? memcg_kmem_put_cache+0x5/0x60
Nov 15 12:05:19 deepblue kernel:  genl_family_rcv_msg+0x1f9/0x470
Nov 15 12:05:19 deepblue kernel:  genl_rcv_msg+0x47/0x90
Nov 15 12:05:19 deepblue kernel:  ? genl_family_rcv_msg+0x470/0x470
Nov 15 12:05:19 deepblue kernel:  netlink_rcv_skb+0x75/0x140
Nov 15 12:05:19 deepblue kernel:  genl_rcv+0x24/0x40
Nov 15 12:05:19 deepblue kernel:  netlink_unicast+0x179/0x230
Nov 15 12:05:19 deepblue kernel:  netlink_sendmsg+0x21e/0x3e0
Nov 15 12:05:19 deepblue kernel:  sock_sendmsg+0x5e/0x60
Nov 15 12:05:19 deepblue kernel:  __sys_sendto+0x112/0x160
Nov 15 12:05:19 deepblue kernel:  __x64_sys_sendto+0x25/0x30
Nov 15 12:05:19 deepblue kernel:  do_syscall_64+0x43/0x80
Nov 15 12:05:19 deepblue kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Nov 15 12:05:19 deepblue kernel: RIP: 0033:0x7f1f37f25730
Nov 15 12:05:19 deepblue kernel: Code: c0 ff ff ff ff eb b8 0f 1f 00 f3 0f =
1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 1d 45 31 c9 45 31 c0 b8 2c =
00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 68 c3 0f 1f 80 00 00 00 00 55 48 83 e=
c 20 48
Nov 15 12:05:19 deepblue kernel: RSP: 002b:00007ffe5651d958 EFLAGS: 0000024=
6 ORIG_RAX: 000000000000002c
Nov 15 12:05:19 deepblue kernel: RAX: ffffffffffffffda RBX: 0000556f0116732=
0 RCX: 00007f1f37f25730
Nov 15 12:05:19 deepblue kernel: RDX: 000000000000001c RSI: 0000556f0117235=
0 RDI: 0000000000000004
Nov 15 12:05:19 deepblue kernel: RBP: 0000556f0117c680 R08: 000000000000000=
0 R09: 0000000000000000
Nov 15 12:05:19 deepblue kernel: R10: 0000000000000000 R11: 000000000000024=
6 R12: 00007ffe5651d9bc
Nov 15 12:05:19 deepblue kernel: R13: 00007ffe5651d9b8 R14: 0000556f01170fb=
0 R15: 0000000000000000
Nov 15 12:05:19 deepblue kernel: ---[ end trace 15134a5adecd2aee ]---
Nov 15 12:05:19 deepblue kernel: [drm] failed to retrieve link info, disabl=
ing eDP
Nov 15 12:05:19 deepblue connmand[363]: Connection Manager version 1.38
Nov 15 12:05:19 deepblue connmand[363]: Adding configuration pasithea
Nov 15 12:05:19 deepblue connmand[363]: Ignore group named 'global' because=
 prefix is not 'service_'
Nov 15 12:05:19 deepblue connmand[363]: Mismatch with passphrase and settin=
g Security =3D WPA2 PSK
Nov 15 12:05:19 deepblue connmand[363]: Adding service configuration pasith=
ea
Nov 15 12:05:19 deepblue connmand[363]: Mismatch with passphrase and settin=
g Security =3D WPA2 PSK
Nov 15 12:05:19 deepblue connmand[363]: Adding service configuration samsung
Nov 15 12:05:19 deepblue kernel: [drm] Initialized i915 1.6.0 20190822 for =
0000:00:02.0 on minor 0
Nov 15 12:05:19 deepblue kernel: ACPI: Video Device [GFX0] (multi-head: yes=
  rom: no  post: no)
Nov 15 12:05:19 deepblue kernel: input: Video Bus as /devices/LNXSYSTM:00/L=
NXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input5
Nov 15 12:05:19 deepblue kernel: snd_hda_intel 0000:00:1f.3: bound 0000:00:=
02.0 (ops i915_audio_component_bind_ops [i915])
Nov 15 12:05:19 deepblue iwd[304]: src/manager.c:manager_config_notify() No=
tification of command Del Interface(8)
Nov 15 12:05:19 deepblue iwd[304]: src/netdev.c:netdev_link_notify() event =
17 on ifindex 3
Nov 15 12:05:19 deepblue iwd[304]: src/manager.c:manager_del_interface_cb()
Nov 15 12:05:19 deepblue iwd[304]: src/manager.c:manager_create_interfaces(=
) creating wlan0
Nov 15 12:05:19 deepblue iwd[304]: src/manager.c:manager_create_interfaces(=
) creating wlan0-p2p
Nov 15 12:05:19 deepblue iwd[304]: src/manager.c:manager_config_notify() No=
tification of command New Interface(7)
Nov 15 12:05:19 deepblue iwd[304]: src/netdev.c:netdev_link_notify() event =
16 on ifindex 4
Nov 15 12:05:19 deepblue iwd[304]: src/manager.c:manager_new_station_interf=
ace_cb()
Nov 15 12:05:19 deepblue iwd[304]: src/netdev.c:netdev_create_from_genl() C=
reated interface wlan0[4 2]
Nov 15 12:05:19 deepblue iwd[304]: src/netdev.c:netdev_cqm_rssi_update()
Nov 15 12:05:19 deepblue iwd[304]: src/manager.c:manager_config_notify() No=
tification of command New Interface(7)
Nov 15 12:05:19 deepblue iwd[304]: src/manager.c:manager_new_p2p_interface_=
cb()
Nov 15 12:05:19 deepblue iwd[304]: src/p2p.c:p2p_device_update_from_genl() =
Created P2P device 3
Nov 15 12:05:19 deepblue systemd-udevd[188]: Using default interface naming=
 scheme 'v245'.
Nov 15 12:05:19 deepblue dbus-daemon[303]: [system] Activating via systemd:=
 service name=3D'net.connman.vpn' unit=3D'connman-vpn.service' requested by=
 ':1.2' (uid=3D0 pid=3D363 comm=3D"/usr/bin/connmand --wifi=3Diwd_agent -n =
")
Nov 15 12:05:19 deepblue kernel: snd_hda_codec_realtek hdaudioC0D0: autocon=
fig for ALC283: line_outs=3D1 (0x21/0x0/0x0/0x0/0x0) type:hp
Nov 15 12:05:19 deepblue kernel: snd_hda_codec_realtek hdaudioC0D0:    spea=
ker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
Nov 15 12:05:19 deepblue kernel: snd_hda_codec_realtek hdaudioC0D0:    hp_o=
uts=3D0 (0x0/0x0/0x0/0x0/0x0)
Nov 15 12:05:19 deepblue kernel: snd_hda_codec_realtek hdaudioC0D0:    mono=
: mono_out=3D0x0
Nov 15 12:05:19 deepblue kernel: snd_hda_codec_realtek hdaudioC0D0:    inpu=
ts:
Nov 15 12:05:19 deepblue kernel: snd_hda_codec_realtek hdaudioC0D0:      Mi=
c=3D0x19
Nov 15 12:05:19 deepblue dbus-daemon[303]: [system] Activating via systemd:=
 service name=3D'org.freedesktop.resolve1' unit=3D'dbus-org.freedesktop.res=
olve1.service' requested by ':1.2' (uid=3D0 pid=3D363 comm=3D"/usr/bin/conn=
mand --wifi=3Diwd_agent -n ")
Nov 15 12:05:19 deepblue dbus-daemon[303]: [system] Successfully activated =
service 'net.connman.vpn'
Nov 15 12:05:19 deepblue connman-vpnd[371]: Connection Manager VPN daemon v=
ersion 1.38
Nov 15 12:05:19 deepblue kernel: usb 1-4: New USB device found, idVendor=3D=
046d, idProduct=3Dc52b, bcdDevice=3D12.03
Nov 15 12:05:19 deepblue kernel: usb 1-4: New USB device strings: Mfr=3D1, =
Product=3D2, SerialNumber=3D0
Nov 15 12:05:19 deepblue kernel: usb 1-4: Product: USB Receiver
Nov 15 12:05:19 deepblue kernel: usb 1-4: Manufacturer: Logitech
Nov 15 12:05:19 deepblue kernel: input: HDA Digital PCBeep as /devices/pci0=
000:00/0000:00:1f.3/sound/card0/input6
Nov 15 12:05:19 deepblue kernel: input: HDA Intel PCH Mic as /devices/pci00=
00:00/0000:00:1f.3/sound/card0/input7
Nov 15 12:05:19 deepblue kernel: input: HDA Intel PCH Headphone as /devices=
/pci0000:00/0000:00:1f.3/sound/card0/input8
Nov 15 12:05:19 deepblue kernel: input: HDA Intel PCH HDMI/DP,pcm=3D3 as /d=
evices/pci0000:00/0000:00:1f.3/sound/card0/input9
Nov 15 12:05:19 deepblue kernel: input: HDA Intel PCH HDMI/DP,pcm=3D7 as /d=
evices/pci0000:00/0000:00:1f.3/sound/card0/input10
Nov 15 12:05:19 deepblue kernel: input: HDA Intel PCH HDMI/DP,pcm=3D8 as /d=
evices/pci0000:00/0000:00:1f.3/sound/card0/input11
Nov 15 12:05:19 deepblue kernel: input: HDA Intel PCH HDMI/DP,pcm=3D9 as /d=
evices/pci0000:00/0000:00:1f.3/sound/card0/input12
Nov 15 12:05:19 deepblue kernel: input: HDA Intel PCH HDMI/DP,pcm=3D10 as /=
devices/pci0000:00/0000:00:1f.3/sound/card0/input13
Nov 15 12:05:20 deepblue kernel: usb 1-7: new full-speed USB device number =
3 using xhci_hcd
Nov 15 12:05:20 deepblue iwd[304]: src/netdev.c:netdev_link_notify() event =
16 on ifindex 4
Nov 15 12:05:20 deepblue iwd[304]: src/wiphy.c:wiphy_reg_notify() Notificat=
ion of command Wiphy Reg Change(113)
Nov 15 12:05:20 deepblue iwd[304]: src/wiphy.c:wiphy_update_reg_domain() Ne=
w reg domain country code for phy0 is XX
Nov 15 12:05:20 deepblue iwd[304]: src/netdev.c:netdev_set_4addr() netdev: =
4 use_4addr: 0
Nov 15 12:05:20 deepblue iwd[304]: src/netdev.c:netdev_initial_up_cb() Inte=
rface 4 initialized
Nov 15 12:05:20 deepblue iwd[304]: src/station.c:station_enter_state() Old =
State: disconnected, new state: autoconnect_quick
Nov 15 12:05:20 deepblue iwd[304]: src/wiphy.c:wiphy_radio_work_insert() In=
serting work item 1
Nov 15 12:05:20 deepblue iwd[304]: src/wiphy.c:wiphy_radio_work_next() Star=
ting work item 1
Nov 15 12:05:20 deepblue iwd[304]: src/netdev.c:netdev_link_notify() event =
16 on ifindex 4
Nov 15 12:05:20 deepblue iwd[304]: src/manager.c:manager_config_notify() No=
tification of command Set Interface(6)
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:scan_notify() Scan notificati=
on Trigger Scan(33)
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:scan_request_triggered() Acti=
ve scan triggered for wdev 2
Nov 15 12:05:20 deepblue iwd[304]: src/station.c:station_quick_scan_trigger=
ed() Quick scan triggered for wlan0
Nov 15 12:05:20 deepblue connman-vpnd[371]: wlan0 {create} index 4 type 1 <=
ETHER>
Nov 15 12:05:20 deepblue connman-vpnd[371]: wlan0 {update} flags 4163 <UP,R=
UNNING>
Nov 15 12:05:20 deepblue connman-vpnd[371]: wlan0 {newlink} index 4 address=
 AC:ED:5C:F1:20:84 mtu 1500
Nov 15 12:05:20 deepblue connman-vpnd[371]: wlan0 {newlink} index 4 opersta=
te 0 <UNKNOWN>
Nov 15 12:05:20 deepblue connman-vpnd[371]: wlan0 {newlink} index 4 address=
 AC:ED:5C:F1:20:84 mtu 1500
Nov 15 12:05:20 deepblue connman-vpnd[371]: wlan0 {newlink} index 4 opersta=
te 0 <UNKNOWN>
Nov 15 12:05:20 deepblue connman-vpnd[371]: lo {newlink} index 1 operstate =
0 <UNKNOWN>
Nov 15 12:05:20 deepblue connman-vpnd[371]: eno1 {create} index 2 type 1 <E=
THER>
Nov 15 12:05:20 deepblue connman-vpnd[371]: eno1 {update} flags 4098 <DOWN>
Nov 15 12:05:20 deepblue connman-vpnd[371]: eno1 {newlink} index 2 address =
94:C6:91:13:A0:64 mtu 1500
Nov 15 12:05:20 deepblue connman-vpnd[371]: eno1 {newlink} index 2 operstat=
e 2 <DOWN>
Nov 15 12:05:20 deepblue connman-vpnd[371]: wlan0 {newlink} index 4 address=
 AC:ED:5C:F1:20:84 mtu 1500
Nov 15 12:05:20 deepblue connman-vpnd[371]: wlan0 {newlink} index 4 opersta=
te 0 <UNKNOWN>
Nov 15 12:05:20 deepblue iwd[304]: src/netdev.c:netdev_link_notify() event =
16 on ifindex 4
Nov 15 12:05:20 deepblue connman-vpnd[371]: wlan0 {update} flags 4099 <UP>
Nov 15 12:05:20 deepblue connman-vpnd[371]: wlan0 {newlink} index 4 address=
 AC:ED:5C:F1:20:84 mtu 1500
Nov 15 12:05:20 deepblue connman-vpnd[371]: wlan0 {newlink} index 4 opersta=
te 2 <DOWN>
Nov 15 12:05:20 deepblue connmand[363]: wlan0 {create} index 4 type 1 <ETHE=
R>
Nov 15 12:05:20 deepblue connmand[363]: wlan0 {update} flags 4163 <UP,RUNNI=
NG>
Nov 15 12:05:20 deepblue connmand[363]: wlan0 {newlink} index 4 address AC:=
ED:5C:F1:20:84 mtu 1500
Nov 15 12:05:20 deepblue connmand[363]: wlan0 {newlink} index 4 operstate 0=
 <UNKNOWN>
Nov 15 12:05:20 deepblue connmand[363]: Adding interface wlan0 [ wifi ]
Nov 15 12:05:20 deepblue connmand[363]: wlan0 {newlink} index 4 address AC:=
ED:5C:F1:20:84 mtu 1500
Nov 15 12:05:20 deepblue connmand[363]: wlan0 {newlink} index 4 operstate 0=
 <UNKNOWN>
Nov 15 12:05:20 deepblue connmand[363]: lo {newlink} index 1 address 00:00:=
00:00:00:00 mtu 65536
Nov 15 12:05:20 deepblue connmand[363]: lo {newlink} index 1 operstate 0 <U=
NKNOWN>
Nov 15 12:05:20 deepblue connmand[363]: eno1 {create} index 2 type 1 <ETHER>
Nov 15 12:05:20 deepblue connmand[363]: eno1 {update} flags 4098 <DOWN>
Nov 15 12:05:20 deepblue connmand[363]: eno1 {newlink} index 2 address 94:C=
6:91:13:A0:64 mtu 1500
Nov 15 12:05:20 deepblue connmand[363]: eno1 {newlink} index 2 operstate 2 =
<DOWN>
Nov 15 12:05:20 deepblue dbus-daemon[303]: [system] Activating via systemd:=
 service name=3D'org.freedesktop.hostname1' unit=3D'dbus-org.freedesktop.ho=
stname1.service' requested by ':1.2' (uid=3D0 pid=3D363 comm=3D"/usr/bin/co=
nnmand --wifi=3Diwd_agent -n ")
Nov 15 12:05:20 deepblue kernel: usb 1-7: New USB device found, idVendor=3D=
8087, idProduct=3D0a2b, bcdDevice=3D 0.01
Nov 15 12:05:20 deepblue kernel: usb 1-7: New USB device strings: Mfr=3D0, =
Product=3D0, SerialNumber=3D0
Nov 15 12:05:20 deepblue kernel: fbcon: i915drmfb (fb0) is primary device
Nov 15 12:05:20 deepblue mtp-probe[386]: checking bus 1, device 2: "/sys/de=
vices/pci0000:00/0000:00:14.0/usb1/1-4"
Nov 15 12:05:20 deepblue mtp-probe[386]: bus: 1, device: 2 was not an MTP d=
evice
Nov 15 12:05:20 deepblue kernel: usbcore: registered new interface driver u=
sbhid
Nov 15 12:05:20 deepblue kernel: usbhid: USB HID core driver
Nov 15 12:05:20 deepblue mtp-probe[389]: checking bus 1, device 2: "/sys/de=
vices/pci0000:00/0000:00:14.0/usb1/1-4"
Nov 15 12:05:20 deepblue mtp-probe[389]: bus: 1, device: 2 was not an MTP d=
evice
Nov 15 12:05:20 deepblue kernel: input: Logitech USB Receiver as /devices/p=
ci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:046D:C52B.0001/input/input14
Nov 15 12:05:20 deepblue systemd-resolved[299]: Positive Trust Anchors:
Nov 15 12:05:20 deepblue systemd-resolved[299]: . IN DS 20326 8 2 e06d44b80=
b8f1d39a95c0b0d7c65d08458e880409bbc683457104237c7f8ec8d
Nov 15 12:05:20 deepblue kernel: Console: switching to colour frame buffer =
device 240x67
Nov 15 12:05:20 deepblue systemd-resolved[299]: Negative trust anchors: 10.=
in-addr.arpa 16.172.in-addr.arpa 17.172.in-addr.arpa 18.172.in-addr.arpa 19=
.172.in-addr.arpa 20.172.in-addr.arpa 21.172.in-addr.arpa 22.172.in-addr.ar=
pa 23.172.in-addr.arpa 24.172.in-addr.arpa 25.172.in-addr.arpa 26.172.in-ad=
dr.arpa 27.172.in-addr.arpa 28.172.in-addr.arpa 29.172.in-addr.arpa 30.172.=
in-addr.arpa 31.172.in-addr.arpa 168.192.in-addr.arpa d.f.ip6.arpa corp hom=
e internal intranet lan local private test
Nov 15 12:05:20 deepblue kernel: Bluetooth: Core ver 2.22
Nov 15 12:05:20 deepblue kernel: NET: Registered protocol family 31
Nov 15 12:05:20 deepblue kernel: Bluetooth: HCI device and connection manag=
er initialized
Nov 15 12:05:20 deepblue kernel: Bluetooth: HCI socket layer initialized
Nov 15 12:05:20 deepblue kernel: Bluetooth: L2CAP socket layer initialized
Nov 15 12:05:20 deepblue kernel: Bluetooth: SCO socket layer initialized
Nov 15 12:05:20 deepblue kernel: i915 0000:00:02.0: fb0: i915drmfb frame bu=
ffer device
Nov 15 12:05:20 deepblue kernel: usbcore: registered new interface driver b=
tusb
Nov 15 12:05:20 deepblue kernel: Bluetooth: hci0: Firmware revision 0.0 bui=
ld 10 week 41 2018
Nov 15 12:05:20 deepblue systemd-logind[305]: Watching system buttons on /d=
ev/input/event2 (Power Button)
Nov 15 12:05:20 deepblue kernel: hid-generic 0003:046D:C52B.0001: input,hid=
raw0: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-0000:00:14.0-4/=
input0
Nov 15 12:05:20 deepblue kernel: input: Logitech USB Receiver Mouse as /dev=
ices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.1/0003:046D:C52B.0002/input/inp=
ut15
Nov 15 12:05:20 deepblue kernel: input: Logitech USB Receiver Consumer Cont=
rol as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.1/0003:046D:C52B.000=
2/input/input16
Nov 15 12:05:20 deepblue connmand[363]: Adding interface eno1 [ ethernet ]
Nov 15 12:05:20 deepblue iwd[304]: src/netdev.c:netdev_link_notify() event =
16 on ifindex 2
Nov 15 12:05:20 deepblue systemd-udevd[188]: ethtool: autonegotiation is un=
set or enabled, the speed and duplex are not writable.
Nov 15 12:05:20 deepblue connmand[363]: wlan0 {update} flags 4099 <UP>
Nov 15 12:05:20 deepblue connmand[363]: wlan0 {newlink} index 4 address AC:=
ED:5C:F1:20:84 mtu 1500
Nov 15 12:05:20 deepblue connmand[363]: wlan0 {newlink} index 4 operstate 2=
 <DOWN>
Nov 15 12:05:20 deepblue connmand[363]: wlan0 {newlink} index 4 address AC:=
ED:5C:F1:20:84 mtu 1500
Nov 15 12:05:20 deepblue connmand[363]: wlan0 {newlink} index 4 operstate 2=
 <DOWN>
Nov 15 12:05:20 deepblue connmand[363]: eno1 {update} flags 36867 <UP>
Nov 15 12:05:20 deepblue connmand[363]: eno1 {newlink} index 2 address 94:C=
6:91:13:A0:64 mtu 1500
Nov 15 12:05:20 deepblue connmand[363]: eno1 {newlink} index 2 operstate 2 =
<DOWN>
Nov 15 12:05:20 deepblue connman-vpnd[371]: eno1 {update} flags 36867 <UP>
Nov 15 12:05:20 deepblue connman-vpnd[371]: eno1 {newlink} index 2 address =
94:C6:91:13:A0:64 mtu 1500
Nov 15 12:05:20 deepblue connman-vpnd[371]: eno1 {newlink} index 2 operstat=
e 2 <DOWN>
Nov 15 12:05:20 deepblue iwd[304]: src/agent.c:agent_register() agent regis=
ter called
Nov 15 12:05:20 deepblue iwd[304]: src/agent.c:agent_register() agent :1.2 =
path /net/connman/iwd_agent
Nov 15 12:05:20 deepblue systemd-logind[305]: Watching system buttons on /d=
ev/input/event1 (Power Button)
Nov 15 12:05:20 deepblue systemd-logind[305]: Watching system buttons on /d=
ev/input/event0 (Sleep Button)
Nov 15 12:05:20 deepblue kernel: input: Logitech USB Receiver System Contro=
l as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.1/0003:046D:C52B.0002/=
input/input17
Nov 15 12:05:20 deepblue kernel: hid-generic 0003:046D:C52B.0002: input,hid=
dev0,hidraw1: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:14=
.0-4/input1
Nov 15 12:05:20 deepblue kernel: hid-generic 0003:046D:C52B.0003: hiddev1,h=
idraw2: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-4/=
input2
Nov 15 12:05:20 deepblue kernel: random: crng init done
Nov 15 12:05:20 deepblue kernel: random: 1 urandom warning(s) missed due to=
 ratelimiting
Nov 15 12:05:20 deepblue kernel: logitech-djreceiver 0003:046D:C52B.0003: h=
iddev0,hidraw0: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00=
:14.0-4/input2
Nov 15 12:05:20 deepblue systemd-resolved[299]: Using system hostname 'deep=
blue'.
Nov 15 12:05:20 deepblue dbus-daemon[303]: [system] Successfully activated =
service 'org.freedesktop.resolve1'
Nov 15 12:05:20 deepblue systemd-fsck[401]: fsck.fat 4.1 (2017-01-24)
Nov 15 12:05:20 deepblue systemd-fsck[401]: /dev/sda1: 192 files, 70036/201=
616 clusters
Nov 15 12:05:20 deepblue systemd-logind[305]: Watching system buttons on /d=
ev/input/event3 (ITE8713 CIR transceiver)
Nov 15 12:05:20 deepblue systemd-logind[305]: New seat seat0.
Nov 15 12:05:20 deepblue bootctl[397]: Random seed file /boot/loader/random=
-seed successfully written (512 bytes).
Nov 15 12:05:20 deepblue kernel: input: Logitech Unifying Device. Wireless =
PID:4055 Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.2/0003:04=
6D:C52B.0003/0003:046D:4055.0004/input/input19
Nov 15 12:05:20 deepblue kernel: hid-generic 0003:046D:4055.0004: input,hid=
raw1: USB HID v1.11 Mouse [Logitech Unifying Device. Wireless PID:4055] on =
usb-0000:00:14.0-4/input2:1
Nov 15 12:05:20 deepblue kernel: input: Logitech Unifying Device. Wireless =
PID:2011 Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.2/0003=
:046D:C52B.0003/0003:046D:2011.0005/input/input23
Nov 15 12:05:20 deepblue kernel: input: Logitech Unifying Device. Wireless =
PID:2011 Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:=
1.2/0003:046D:C52B.0003/0003:046D:2011.0005/input/input24
Nov 15 12:05:20 deepblue kernel: input: Logitech Unifying Device. Wireless =
PID:2011 System Control as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.=
2/0003:046D:C52B.0003/0003:046D:2011.0005/input/input25
Nov 15 12:05:20 deepblue kernel: hid-generic 0003:046D:2011.0005: input,hid=
raw2: USB HID v1.11 Keyboard [Logitech Unifying Device. Wireless PID:2011] =
on usb-0000:00:14.0-4/input2:2
Nov 15 12:05:20 deepblue kernel: mousedev: PS/2 mouse device common for all=
 mice
Nov 15 12:05:20 deepblue sddm[407]: Initializing...
Nov 15 12:05:20 deepblue sddm[407]: Starting...
Nov 15 12:05:20 deepblue sddm[407]: Logind interface found
Nov 15 12:05:20 deepblue sddm[407]: Adding new display on vt 4 ...
Nov 15 12:05:20 deepblue sddm[407]: Loading theme configuration from ""
Nov 15 12:05:20 deepblue sddm[407]: Display server starting...
Nov 15 12:05:20 deepblue sddm[407]: Adding cookie to "/var/run/sddm/{978509=
9b-7460-4620-a392-eaaceab656f0}"
Nov 15 12:05:20 deepblue sddm[407]: Running: /usr/bin/X -nolisten tcp -auth=
 /var/run/sddm/{9785099b-7460-4620-a392-eaaceab656f0} -background none -nor=
eset -displayfd 17 -seat seat0 vt4
Nov 15 12:05:20 deepblue dbus-daemon[303]: [system] Successfully activated =
service 'org.freedesktop.hostname1'
Nov 15 12:05:20 deepblue kernel: input: Logitech Wireless Mouse as /devices=
/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.2/0003:046D:C52B.0003/0003:046D:405=
5.0004/input/input29
Nov 15 12:05:20 deepblue kernel: logitech-hidpp-device 0003:046D:4055.0004:=
 input,hidraw1: USB HID v1.11 Mouse [Logitech Wireless Mouse] on usb-0000:0=
0:14.0-4/input2:1
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:scan_notify() Scan notificati=
on New Scan Results(34)
Nov 15 12:05:20 deepblue iwd[304]: src/netdev.c:netdev_link_notify() event =
16 on ifindex 4
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:get_scan_callback() get_scan_=
callback
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:scan_parse_bss_information_el=
ements() Load: 3/255
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:get_scan_callback() get_scan_=
callback
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:scan_parse_bss_information_el=
ements() Load: 6/255
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:get_scan_callback() get_scan_=
callback
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:get_scan_callback() get_scan_=
callback
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:get_scan_callback() get_scan_=
callback
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:scan_parse_bss_information_el=
ements() Load: 16/255
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:get_scan_callback() get_scan_=
callback
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:scan_parse_bss_information_el=
ements() Load: 35/255
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:get_scan_done() get_scan_done
Nov 15 12:05:20 deepblue iwd[304]: src/station.c:station_add_seen_bss() Pro=
cessing BSS 'cc:ce:1e:94:68:8c' with SSID: Pasithea, freq: 5220, rank: 8928=
, strength: -5500
Nov 15 12:05:20 deepblue iwd[304]: src/station.c:station_add_seen_bss() Add=
ed new Network "Pasithea" security psk
Nov 15 12:05:20 deepblue iwd[304]: src/station.c:station_add_seen_bss() Pro=
cessing BSS 'cc:ce:1e:94:68:8b' with SSID: Pasithea, freq: 2462, rank: 4722=
, strength: -4900
Nov 15 12:05:20 deepblue iwd[304]: src/station.c:station_add_seen_bss() Pro=
cessing BSS '2c:fd:a1:3e:ac:2a' with SSID: Tritium, freq: 2412, rank: 2555,=
 strength: -6700
Nov 15 12:05:20 deepblue iwd[304]: src/station.c:station_add_seen_bss() Add=
ed new Network "Tritium" security psk
Nov 15 12:05:20 deepblue iwd[304]: src/station.c:station_add_seen_bss() Pro=
cessing BSS '44:4e:6d:dd:b9:e8' with SSID: Pasithea, freq: 2462, rank: 2440=
, strength: -7500
Nov 15 12:05:20 deepblue iwd[304]: src/station.c:station_add_seen_bss() Pro=
cessing BSS '44:4e:6d:dd:b9:e7' with SSID: Pasithea, freq: 5220, rank: 1868=
, strength: -7900
Nov 15 12:05:20 deepblue iwd[304]: src/station.c:station_add_seen_bss() Pro=
cessing BSS '06:0e:3c:5f:a8:ab' with SSID: DIRECT-AB-HP OfficeJet 5200, fre=
q: 2412, rank: 1224, strength: -8300
Nov 15 12:05:20 deepblue iwd[304]: src/station.c:station_add_seen_bss() Add=
ed new Network "DIRECT-AB-HP OfficeJet 5200" security psk
Nov 15 12:05:20 deepblue iwd[304]: src/station.c:station_autoconnect_next()=
 Considering autoconnecting to BSS 'cc:ce:1e:94:68:8c' with SSID: Pasithea,=
 freq: 5220, rank: 8928, strength: -5500
Nov 15 12:05:20 deepblue iwd[304]: src/station.c:station_enter_state() Old =
State: autoconnect_quick, new state: autoconnect_full
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:scan_periodic_start() Startin=
g periodic scan for wdev 2
Nov 15 12:05:20 deepblue iwd[304]: src/wiphy.c:wiphy_radio_work_insert() In=
serting work item 2
Nov 15 12:05:20 deepblue iwd[304]: src/wiphy.c:wiphy_radio_work_done() Work=
 item 1 done
Nov 15 12:05:20 deepblue iwd[304]: src/wiphy.c:wiphy_radio_work_next() Star=
ting work item 2
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:scan_notify() Scan notificati=
on Trigger Scan(33)
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:scan_request_triggered() Pass=
ive scan triggered for wdev 2
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:scan_periodic_triggered() Per=
iodic scan triggered for wdev 2
Nov 15 12:05:20 deepblue connmand[363]: ipconfig state 2 ipconfig method 1
Nov 15 12:05:20 deepblue iwd[304]: src/network.c:network_connect()
Nov 15 12:05:20 deepblue iwd[304]: src/network.c:network_connect_psk() ask_=
passphrase: false
Nov 15 12:05:20 deepblue iwd[304]: src/wiphy.c:wiphy_radio_work_insert() In=
serting work item 3
Nov 15 12:05:20 deepblue iwd[304]: src/station.c:station_enter_state() Old =
State: autoconnect_full, new state: connecting
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:scan_periodic_stop() Stopping=
 periodic scan for wdev 2
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:scan_cancel() Trying to cance=
l scan id 2 for wdev 2
Nov 15 12:05:20 deepblue iwd[304]: src/scan.c:scan_cancel() Scan is at the =
top of the queue and triggered
Nov 15 12:05:20 deepblue kernel: input: Logitech K520 as /devices/pci0000:0=
0/0000:00:14.0/usb1/1-4/1-4:1.2/0003:046D:C52B.0003/0003:046D:2011.0005/inp=
ut/input30
Nov 15 12:05:20 deepblue kernel: logitech-hidpp-device 0003:046D:2011.0005:=
 input,hidraw2: USB HID v1.11 Keyboard [Logitech K520] on usb-0000:00:14.0-=
4/input2:2
Nov 15 12:05:20 deepblue connmand[363]: ipconfig state 3 ipconfig method 1
Nov 15 12:05:21 deepblue systemd-logind[305]: Watching system buttons on /d=
ev/input/event15 (Logitech K520)
Nov 15 12:05:22 deepblue sddm[407]: Setting default cursor
Nov 15 12:05:23 deepblue sddm[407]: Running display setup script  "/usr/sha=
re/sddm/scripts/Xsetup"
Nov 15 12:05:23 deepblue sddm[407]: Display server started.
Nov 15 12:05:23 deepblue sddm[407]: Socket server starting...
Nov 15 12:05:23 deepblue sddm[407]: Socket server started.
Nov 15 12:05:23 deepblue sddm[407]: Loading theme configuration from "/usr/=
share/sddm/themes/luna/theme.conf"
Nov 15 12:05:23 deepblue sddm[407]: Greeter starting...
Nov 15 12:05:23 deepblue sddm-helper[432]: [PAM] Starting...
Nov 15 12:05:23 deepblue sddm-helper[432]: [PAM] Authenticating...
Nov 15 12:05:23 deepblue sddm-helper[432]: [PAM] returning.
Nov 15 12:05:23 deepblue sddm-helper[432]: pam_unix(sddm-greeter:session): =
session opened for user sddm(uid=3D976) by (uid=3D0)
Nov 15 12:05:23 deepblue systemd-logind[305]: New session c1 of user sddm.
Nov 15 12:05:23 deepblue dbus-daemon[303]: [system] Activating via systemd:=
 service name=3D'org.freedesktop.home1' unit=3D'dbus-org.freedesktop.home1.=
service' requested by ':1.11' (uid=3D0 pid=3D437 comm=3D"(systemd) ")
Nov 15 12:05:23 deepblue dbus-daemon[303]: [system] Activation via systemd =
failed for unit 'dbus-org.freedesktop.home1.service': Unit dbus-org.freedes=
ktop.home1.service not found.
Nov 15 12:05:23 deepblue systemd[437]: pam_systemd_home(systemd-user:accoun=
t): systemd-homed is not available: Unit dbus-org.freedesktop.home1.service=
 not found.
Nov 15 12:05:23 deepblue systemd[437]: pam_warn(systemd-user:setcred): func=
tion=3D[pam_sm_setcred] flags=3D0x8002 service=3D[systemd-user] terminal=3D=
[] user=3D[sddm] ruser=3D[<unknown>] rhost=3D[<unknown>]
Nov 15 12:05:23 deepblue systemd[437]: pam_unix(systemd-user:session): sess=
ion opened for user sddm(uid=3D976) by (uid=3D0)
Nov 15 12:05:23 deepblue systemd[445]: Configuration file /etc/xdg/autostar=
t/klipper.desktop is marked executable. Please remove executable permission=
 bits. Proceeding anyway.
Nov 15 12:05:23 deepblue systemd[445]: Not generating service for XDG autos=
tart app-pulseaudio-autostart.service, startup phases are not supported.
Nov 15 12:05:23 deepblue systemd[445]: Not generating service for XDG autos=
tart app-kaccess-autostart.service, only Type=3DApplication is supported.
Nov 15 12:05:23 deepblue systemd[445]: Not generating service for XDG autos=
tart app-at\x2dspi\x2ddbus\x2dbus-autostart.service, startup phases are not=
 supported.
Nov 15 12:05:23 deepblue sddm[407]: Greeter session started successfully
Nov 15 12:05:23 deepblue sddm-greeter[448]: High-DPI autoscaling not Enabled
Nov 15 12:05:23 deepblue sddm-greeter[448]: Reading from "/usr/share/xsessi=
ons/plasma.desktop"
Nov 15 12:05:23 deepblue sddm-greeter[448]: Loading theme configuration fro=
m "/usr/share/sddm/themes/luna/theme.conf"
Nov 15 12:05:23 deepblue sddm-greeter[448]: Connected to the daemon.
Nov 15 12:05:23 deepblue sddm[407]: Message received from greeter: Connect
Nov 15 12:05:23 deepblue sddm-greeter[448]: Loading file:///usr/share/sddm/=
themes/luna/Main.qml...
Nov 15 12:05:23 deepblue dbus-daemon[303]: [system] Activating via systemd:=
 service name=3D'org.freedesktop.UDisks2' unit=3D'udisks2.service' requeste=
d by ':1.13' (uid=3D976 pid=3D448 comm=3D"/usr/bin/sddm-greeter --socket /t=
mp/sddm-:0-RWCyCv")
Nov 15 12:05:23 deepblue udisksd[458]: udisks daemon version 2.9.1 starting
Nov 15 12:05:23 deepblue dbus-daemon[303]: [system] Activating via systemd:=
 service name=3D'org.freedesktop.PolicyKit1' unit=3D'polkit.service' reques=
ted by ':1.14' (uid=3D0 pid=3D458 comm=3D"/usr/lib/udisks2/udisksd ")
Nov 15 12:05:23 deepblue polkitd[462]: Started polkitd version 0.118
Nov 15 12:05:23 deepblue polkitd[462]: Loading rules from directory /etc/po=
lkit-1/rules.d
Nov 15 12:05:23 deepblue polkitd[462]: Loading rules from directory /usr/sh=
are/polkit-1/rules.d
Nov 15 12:05:23 deepblue polkitd[462]: Finished loading, compiling and exec=
uting 2 rules
Nov 15 12:05:23 deepblue dbus-daemon[303]: [system] Successfully activated =
service 'org.freedesktop.PolicyKit1'
Nov 15 12:05:23 deepblue polkitd[462]: Acquired the name org.freedesktop.Po=
licyKit1 on the system bus
Nov 15 12:05:24 deepblue dbus-daemon[303]: [system] Successfully activated =
service 'org.freedesktop.UDisks2'
Nov 15 12:05:24 deepblue dbus-daemon[303]: [system] Activating via systemd:=
 service name=3D'org.freedesktop.UPower' unit=3D'upower.service' requested =
by ':1.13' (uid=3D976 pid=3D448 comm=3D"/usr/bin/sddm-greeter --socket /tmp=
/sddm-:0-RWCyCv")
Nov 15 12:05:24 deepblue udisksd[458]: Acquired the name org.freedesktop.UD=
isks2 on the system message bus
Nov 15 12:05:24 deepblue iwd[304]: src/wiphy.c:wiphy_reg_notify() Notificat=
ion of command Wiphy Reg Change(113)
Nov 15 12:05:24 deepblue iwd[304]: src/wiphy.c:wiphy_update_reg_domain() Ne=
w reg domain country code for phy0 is DE
Nov 15 12:05:24 deepblue iwd[304]: src/scan.c:scan_notify() Scan notificati=
on New Scan Results(34)
Nov 15 12:05:24 deepblue iwd[304]: src/wiphy.c:wiphy_radio_work_done() Work=
 item 2 done
Nov 15 12:05:24 deepblue iwd[304]: src/wiphy.c:wiphy_radio_work_next() Star=
ting work item 3
Nov 15 12:05:24 deepblue iwd[304]: src/netdev.c:netdev_link_notify() event =
16 on ifindex 4
Nov 15 12:05:24 deepblue kernel: wlan0: authenticate with cc:ce:1e:94:68:8c
Nov 15 12:05:24 deepblue iwd[304]: src/netdev.c:netdev_mlme_notify() MLME n=
otification New Station(19)
Nov 15 12:05:24 deepblue iwd[304]: src/station.c:station_netdev_event() Ass=
ociating
Nov 15 12:05:24 deepblue kernel: wlan0: send auth to cc:ce:1e:94:68:8c (try=
 1/3)
Nov 15 12:05:24 deepblue iwd[304]: src/netdev.c:netdev_mlme_notify() MLME n=
otification Authenticate(37)
Nov 15 12:05:24 deepblue iwd[304]: src/netdev.c:netdev_authenticate_event()
Nov 15 12:05:24 deepblue kernel: wlan0: send auth to cc:ce:1e:94:68:8c (try=
 2/3)
Nov 15 12:05:24 deepblue kernel: wlan0: authenticated
Nov 15 12:05:24 deepblue kernel: wlan0: associate with cc:ce:1e:94:68:8c (t=
ry 1/3)
Nov 15 12:05:24 deepblue kernel: wlan0: RX AssocResp from cc:ce:1e:94:68:8c=
 (capab=3D0x1511 status=3D0 aid=3D1)
Nov 15 12:05:24 deepblue iwd[304]: src/netdev.c:netdev_mlme_notify() MLME n=
otification Associate(38)
Nov 15 12:05:24 deepblue iwd[304]: src/netdev.c:netdev_associate_event()
Nov 15 12:05:24 deepblue iwd[304]: src/netdev.c:netdev_mlme_notify() MLME n=
otification Connect(46)
Nov 15 12:05:24 deepblue iwd[304]: src/netdev.c:netdev_connect_event()
Nov 15 12:05:24 deepblue iwd[304]: src/netdev.c:netdev_link_notify() event =
16 on ifindex 4
Nov 15 12:05:24 deepblue iwd[304]: src/netdev.c:netdev_link_notify() event =
16 on ifindex 4
Nov 15 12:05:24 deepblue iwd[304]: src/netdev.c:netdev_link_notify() event =
16 on ifindex 4
Nov 15 12:05:24 deepblue iwd[304]: src/netdev.c:netdev_link_notify() event =
16 on ifindex 4
Nov 15 12:05:24 deepblue connman-vpnd[371]: wlan0 {update} flags 69635 <UP,=
LOWER_UP>
Nov 15 12:05:24 deepblue connman-vpnd[371]: wlan0 {newlink} index 4 address=
 AC:ED:5C:F1:20:84 mtu 1500
Nov 15 12:05:24 deepblue connman-vpnd[371]: wlan0 {newlink} index 4 opersta=
te 5 <DORMANT>
Nov 15 12:05:24 deepblue connmand[363]: wlan0 {update} flags 69635 <UP,LOWE=
R_UP>
Nov 15 12:05:24 deepblue connmand[363]: wlan0 {newlink} index 4 address AC:=
ED:5C:F1:20:84 mtu 1500
Nov 15 12:05:24 deepblue connmand[363]: wlan0 {newlink} index 4 operstate 5=
 <DORMANT>
Nov 15 12:05:24 deepblue kernel: wlan0: associated
Nov 15 12:05:24 deepblue iwd[304]: src/netdev.c:netdev_unicast_notify() Uni=
cast notification 129
Nov 15 12:05:24 deepblue iwd[304]: src/netdev.c:netdev_control_port_frame_e=
vent()
Nov 15 12:05:24 deepblue iwd[304]: src/eapol.c:eapol_handle_ptk_1_of_4() if=
index=3D4
Nov 15 12:05:24 deepblue iwd[304]: src/netdev.c:netdev_unicast_notify() Uni=
cast notification 129
Nov 15 12:05:24 deepblue iwd[304]: src/netdev.c:netdev_control_port_frame_e=
vent()
Nov 15 12:05:24 deepblue iwd[304]: src/eapol.c:eapol_handle_ptk_3_of_4() if=
index=3D4
Nov 15 12:05:24 deepblue iwd[304]: src/netdev.c:netdev_set_gtk() 4
Nov 15 12:05:24 deepblue iwd[304]: src/station.c:station_handshake_event() =
Setting keys
Nov 15 12:05:24 deepblue iwd[304]: src/netdev.c:netdev_set_tk() 4
Nov 15 12:05:24 deepblue iwd[304]: src/netdev.c:netdev_set_rekey_offload() 4
Nov 15 12:05:24 deepblue iwd[304]: hardware_rekey not supported
Nov 15 12:05:24 deepblue iwd[304]: src/station.c:station_connect_cb() 4, re=
sult: 0
Nov 15 12:05:24 deepblue iwd[304]: src/station.c:station_enter_state() Old =
State: connecting, new state: connected
Nov 15 12:05:24 deepblue iwd[304]: src/wiphy.c:wiphy_radio_work_done() Work=
 item 3 done
Nov 15 12:05:24 deepblue iwd[304]: src/netdev.c:netdev_link_notify() event =
16 on ifindex 4
Nov 15 12:05:24 deepblue connman-vpnd[371]: wlan0 {update} flags 69699 <UP,=
RUNNING,LOWER_UP>
Nov 15 12:05:24 deepblue connman-vpnd[371]: wlan0 {newlink} index 4 address=
 AC:ED:5C:F1:20:84 mtu 1500
Nov 15 12:05:24 deepblue connman-vpnd[371]: wlan0 {newlink} index 4 opersta=
te 6 <UP>
Nov 15 12:05:24 deepblue connmand[363]: wlan0 {RX} 2 packets 282 bytes
Nov 15 12:05:24 deepblue connmand[363]: wlan0 {TX} 2 packets 288 bytes
Nov 15 12:05:24 deepblue connmand[363]: wlan0 {update} flags 69699 <UP,RUNN=
ING,LOWER_UP>
Nov 15 12:05:24 deepblue connmand[363]: wlan0 {newlink} index 4 address AC:=
ED:5C:F1:20:84 mtu 1500
Nov 15 12:05:24 deepblue connmand[363]: wlan0 {newlink} index 4 operstate 6=
 <UP>
Nov 15 12:05:24 deepblue kernel: wlan0: Limiting TX power to 23 (23 - 0) dB=
m as advertised by cc:ce:1e:94:68:8c
Nov 15 12:05:24 deepblue dbus-daemon[303]: [system] Successfully activated =
service 'org.freedesktop.UPower'
Nov 15 12:05:24 deepblue sddm-greeter[448]: Adding view for "HDMI-1" QRect(=
0,0 1920x1080)
Nov 15 12:05:24 deepblue sddm-greeter[448]: Loading file:///usr/share/sddm/=
themes/luna/Main.qml...
Nov 15 12:05:25 deepblue sddm-greeter[448]: Adding view for "HDMI-2" QRect(=
1920,0 1920x1080)
Nov 15 12:05:25 deepblue sddm-greeter[448]: Message received from daemon: C=
apabilities
Nov 15 12:05:25 deepblue sddm-greeter[448]: Message received from daemon: H=
ostName
Nov 15 12:05:26 deepblue connmand[363]: wlan0 {add} address 192.168.178.3/2=
4 label wlan0 family 2
Nov 15 12:05:26 deepblue connmand[363]: ntp: adjust (slew): +0.390007 sec
Nov 15 12:05:26 deepblue connmand[363]: wlan0 {add} route 192.168.178.0 gw =
0.0.0.0 scope 253 <LINK>
Nov 15 12:05:26 deepblue connmand[363]: wlan0 {add} route 192.168.178.1 gw =
0.0.0.0 scope 253 <LINK>
Nov 15 12:05:26 deepblue connmand[363]: wlan0 {add} route 8.8.8.8 gw 192.16=
8.178.1 scope 0 <UNIVERSE>
Nov 15 12:05:26 deepblue connmand[363]: wlan0 {add} route 1.1.1.1 gw 192.16=
8.178.1 scope 0 <UNIVERSE>
Nov 15 12:05:26 deepblue connmand[363]: wlan0 {add} route 0.0.0.0 gw 192.16=
8.178.1 scope 0 <UNIVERSE>
Nov 15 12:05:26 deepblue connmand[363]: Failed to find URL:http://ipv4.conn=
man.net/online/status.html
Nov 15 12:05:26 deepblue connmand[363]: wlan0 {add} route 212.227.81.55 gw =
192.168.178.1 scope 0 <UNIVERSE>
Nov 15 12:05:27 deepblue kernel: logitech-hidpp-device 0003:046D:2011.0005:=
 HID++ 1.0 device connected.
Nov 15 12:05:27 deepblue upowerd[481]: treating change event as add on /sys=
/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.2/0003:046D:C52B.0003/0003:=
046D:2011.0005/power_supply/hidpp_battery_0
Nov 15 12:05:27 deepblue connmand[363]: wlan0 {del} route 212.227.81.55 gw =
192.168.178.1 scope 0 <UNIVERSE>
Nov 15 12:05:32 deepblue sddm-greeter[448]: Reading from "/usr/share/xsessi=
ons/plasma.desktop"
Nov 15 12:05:32 deepblue sddm[407]: Message received from greeter: Login
Nov 15 12:05:32 deepblue sddm[407]: Reading from "/usr/share/xsessions/plas=
ma.desktop"
Nov 15 12:05:32 deepblue sddm[407]: Reading from "/usr/share/xsessions/plas=
ma.desktop"
Nov 15 12:05:32 deepblue sddm[407]: Session "/usr/share/xsessions/plasma.de=
sktop" selected, command: "/usr/bin/startplasma-x11"
Nov 15 12:05:32 deepblue sddm-helper[511]: [PAM] Starting...
Nov 15 12:05:32 deepblue sddm-helper[511]: [PAM] Authenticating...
Nov 15 12:05:32 deepblue sddm-helper[511]: [PAM] Preparing to converse...
Nov 15 12:05:32 deepblue sddm-helper[511]: [PAM] Conversation with 1 messag=
es
Nov 15 12:05:32 deepblue sddm-helper[511]: pam_kwallet5(sddm:auth): (null):=
 pam_sm_authenticate
Nov 15 12:05:32 deepblue sddm-helper[511]: [PAM] returning.
Nov 15 12:05:32 deepblue dbus-daemon[303]: [system] Activating via systemd:=
 service name=3D'org.freedesktop.home1' unit=3D'dbus-org.freedesktop.home1.=
service' requested by ':1.17' (uid=3D0 pid=3D511 comm=3D"/usr/lib/sddm/sddm=
-helper --socket /tmp/sddm-auth7")
Nov 15 12:05:32 deepblue dbus-daemon[303]: [system] Activation via systemd =
failed for unit 'dbus-org.freedesktop.home1.service': Unit dbus-org.freedes=
ktop.home1.service not found.
Nov 15 12:05:32 deepblue sddm-helper[511]: pam_systemd_home(sddm:account): =
systemd-homed is not available: Unit dbus-org.freedesktop.home1.service not=
 found.
Nov 15 12:05:32 deepblue sddm[407]: Authenticated successfully
Nov 15 12:05:32 deepblue sddm-greeter[448]: Message received from daemon: L=
oginSucceeded
Nov 15 12:05:32 deepblue sddm-helper[511]: pam_kwallet5(sddm:setcred): pam_=
kwallet5: pam_sm_setcred
Nov 15 12:05:32 deepblue sddm-helper[511]: pam_unix(sddm:session): session =
opened for user fabiolla(uid=3D1000) by (uid=3D0)
Nov 15 12:05:32 deepblue systemd-logind[305]: New session c2 of user fabiol=
la.
Nov 15 12:05:32 deepblue dbus-daemon[303]: [system] Activating via systemd:=
 service name=3D'org.freedesktop.home1' unit=3D'dbus-org.freedesktop.home1.=
service' requested by ':1.19' (uid=3D0 pid=3D516 comm=3D"(systemd) ")
Nov 15 12:05:32 deepblue dbus-daemon[303]: [system] Activation via systemd =
failed for unit 'dbus-org.freedesktop.home1.service': Unit dbus-org.freedes=
ktop.home1.service not found.
Nov 15 12:05:32 deepblue systemd[516]: pam_systemd_home(systemd-user:accoun=
t): systemd-homed is not available: Unit dbus-org.freedesktop.home1.service=
 not found.
Nov 15 12:05:32 deepblue systemd[516]: pam_warn(systemd-user:setcred): func=
tion=3D[pam_sm_setcred] flags=3D0x8002 service=3D[systemd-user] terminal=3D=
[] user=3D[fabiolla] ruser=3D[<unknown>] rhost=3D[<unknown>]
Nov 15 12:05:32 deepblue systemd[516]: pam_unix(systemd-user:session): sess=
ion opened for user fabiolla(uid=3D1000) by (uid=3D0)
Nov 15 12:05:32 deepblue systemd[525]: Configuration file /etc/xdg/autostar=
t/klipper.desktop is marked executable. Please remove executable permission=
 bits. Proceeding anyway.
Nov 15 12:05:32 deepblue systemd[525]: Not generating service for XDG autos=
tart app-pulseaudio-autostart.service, startup phases are not supported.
Nov 15 12:05:32 deepblue systemd[525]: Not generating service for XDG autos=
tart app-at\x2dspi\x2ddbus\x2dbus-autostart.service, startup phases are not=
 supported.
Nov 15 12:05:32 deepblue systemd[525]: Not generating service for XDG autos=
tart app-kaccess-autostart.service, only Type=3DApplication is supported.
Nov 15 12:05:32 deepblue sddm-helper[432]: [PAM] Closing session
Nov 15 12:05:32 deepblue sddm-helper[432]: pam_unix(sddm-greeter:session): =
session closed for user sddm
Nov 15 12:05:32 deepblue sddm-helper[432]: [PAM] Ended.
Nov 15 12:05:32 deepblue sddm-helper[511]: pam_kwallet5(sddm:session): pam_=
kwallet5: pam_sm_open_session
Nov 15 12:05:32 deepblue sddm[407]: Auth: sddm-helper exited successfully
Nov 15 12:05:32 deepblue sddm[407]: Greeter stopped.
Nov 15 12:05:32 deepblue systemd-logind[305]: Session c1 logged out. Waitin=
g for processes to exit.
Nov 15 12:05:32 deepblue systemd-logind[305]: Removed session c1.
Nov 15 12:05:32 deepblue sddm-helper[532]: pam_kwallet5: final socket path:=
 /run/user/1000/kwallet5.socket
Nov 15 12:05:32 deepblue sddm-helper[511]: Starting: "/usr/share/sddm/scrip=
ts/Xsession \"/usr/bin/startplasma-x11\""
Nov 15 12:05:32 deepblue sddm-helper[535]: Adding cookie to "/home/fabiolla=
/.Xauthority"
Nov 15 12:05:32 deepblue sddm[407]: Session started
Nov 15 12:05:32 deepblue dbus-daemon[543]: [session uid=3D1000 pid=3D543] A=
ctivating service name=3D'org.kde.KSplash' requested by ':1.2' (uid=3D1000 =
pid=3D535 comm=3D"/usr/bin/startplasma-x11 ")
Nov 15 12:05:32 deepblue kcminit_startup[563]: Initializing  "kcm_mouse" : =
 "kcminit_mouse"
Nov 15 12:05:32 deepblue kcminit_startup[563]: Initializing  "kcm_style" : =
 "kcminit_style"
Nov 15 12:05:32 deepblue plasma_session[551]: org.kde.plasma.session: proce=
ss job  "kcminit_startup" finished with exit code  0
Nov 15 12:05:33 deepblue dbus-daemon[543]: [session uid=3D1000 pid=3D543] A=
ctivating service name=3D'org.kde.kglobalaccel' requested by ':1.7' (uid=3D=
1000 pid=3D571 comm=3D"/usr/bin/kded5 ")
Nov 15 12:05:33 deepblue dbus-daemon[543]: [session uid=3D1000 pid=3D543] A=
ctivating service name=3D'org.kde.ActivityManager' requested by ':1.8' (uid=
=3D1000 pid=3D575 comm=3D"/usr/bin/kwin_x11 ")
Nov 15 12:05:33 deepblue dbus-daemon[543]: [session uid=3D1000 pid=3D543] S=
uccessfully activated service 'org.kde.kglobalaccel'
Nov 15 12:05:33 deepblue dbus-daemon[543]: [session uid=3D1000 pid=3D543] S=
uccessfully activated service 'org.kde.ActivityManager'
Nov 15 12:05:33 deepblue kded5[571]: kcm_touchpad: Using X11 backend
Nov 15 12:05:33 deepblue kded5[571]: =

Nov 15 12:05:33 deepblue dbus-daemon[543]: [session uid=3D1000 pid=3D543] A=
ctivating service name=3D'org.kde.KScreen' requested by ':1.7' (uid=3D1000 =
pid=3D571 comm=3D"/usr/bin/kded5 ")
Nov 15 12:05:33 deepblue dbus-daemon[543]: [session uid=3D1000 pid=3D543] S=
uccessfully activated service 'org.kde.KScreen'
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xrandr: Con=
nected output 66 to CRTC 63
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xrandr: Con=
nected output 68 to CRTC 64
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xcb.helper:=
 Detected XRandR 1.6
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xcb.helper:=
 Event Base:  89
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xcb.helper:=
 Event Error:  147
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xrandr: XRa=
ndR::setConfig
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xrandr: Req=
uested screen size is QSize(3840, 1080)
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xrandr: Nee=
ded CRTCs:  2
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xrandr: Act=
ions to perform: =

                                                                 Primary Ou=
tput: false
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xrandr:    =
     Change Screen Size: false
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xrandr:    =
     Disable outputs: false
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xrandr:    =
     Change outputs: true
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xrandr:    =
              (66, 68)
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xrandr:    =
     Enable outputs: false
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xrandr: RRS=
etCrtcConfig (change output) =

                                                                 Output: 66=
 ( "HDMI-1" ) =

                                                                 CRTC: 63 =

                                                                 Pos: QPoin=
t(0,0) =

                                                                 Mode: 70 K=
Screen::Mode(Id: "70" , Size: QSize(1920, 1080) @ 60 ) =

                                                                 Rotation: 1
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xrandr:    =
     Result:  0
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xrandr: XRa=
ndROutput 66 update =

                                                                 m_connecte=
d: 0 =

                                                                 m_crtc XRa=
ndRCrtc(0x5567a74b2650) =

                                                                 CRTC: 63 =

                                                                 MODE: 70 =

                                                                 Connection=
: 0 =

                                                                 Primary: t=
rue
Nov 15 12:05:33 deepblue kcminit_startup[563]: Initializing  "kded_touchpad=
" :  "kcminit_touchpad"
Nov 15 12:05:33 deepblue kcminit_startup[563]: kcm_touchpad: Using X11 back=
end
Nov 15 12:05:33 deepblue plasma_session[551]: org.kde.plasma.session: Start=
ing autostart service  "/etc/xdg/autostart/org.kde.plasmashell.desktop" ("/=
usr/bin/plasmashell")
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xrandr: RRS=
etCrtcConfig (change output) =

                                                                 Output: 68=
 ( "HDMI-2" ) =

                                                                 CRTC: 64 =

                                                                 Pos: QPoin=
t(1920,0) =

                                                                 Mode: 70 K=
Screen::Mode(Id: "70" , Size: QSize(1920, 1080) @ 60 ) =

                                                                 Rotation: 1
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xrandr:    =
     Result:  0
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xrandr: XRa=
ndROutput 68 update =

                                                                 m_connecte=
d: 0 =

                                                                 m_crtc XRa=
ndRCrtc(0x5567a74b2470) =

                                                                 CRTC: 64 =

                                                                 MODE: 70 =

                                                                 Connection=
: 0 =

                                                                 Primary: f=
alse
Nov 15 12:05:33 deepblue kscreen_backend_launcher[604]: kscreen.xrandr: XRa=
ndR::setConfig done!
Nov 15 12:05:33 deepblue plasma_session[551]: org.kde.plasma.session: Start=
ing autostart service  "/etc/xdg/autostart/pam_kwallet_init.desktop" ("/usr=
/lib/pam_kwallet_init")
Nov 15 12:05:33 deepblue plasma_session[551]: org.kde.plasma.session: Start=
ing autostart service  "/etc/xdg/autostart/kaccess.desktop" ("/usr/bin/kacc=
ess")
Nov 15 12:05:33 deepblue plasma_session[551]: org.kde.plasma.session: Start=
ing autostart service  "/etc/xdg/autostart/xembedsniproxy.desktop" ("/usr/b=
in/xembedsniproxy")
Nov 15 12:05:34 deepblue plasma_session[551]: org.kde.plasma.session: Start=
ing autostart service  "/etc/xdg/autostart/polkit-kde-authentication-agent-=
1.desktop" ("/usr/lib/polkit-kde-authentication-agent-1")
Nov 15 12:05:34 deepblue kaccess[618]: Xlib XKB extension major=3D 1  minor=
=3D 0
Nov 15 12:05:34 deepblue plasma_session[551]: org.kde.plasma.session: Start=
ing autostart service  "/etc/xdg/autostart/gmenudbusmenuproxy.desktop" ("/u=
sr/bin/gmenudbusmenuproxy")
Nov 15 12:05:34 deepblue plasma_session[551]: org.kde.plasma.session: Start=
ing autostart service  "/etc/xdg/autostart/org.kde.kdeconnect.daemon.deskto=
p" ("/usr/lib/kdeconnectd")
Nov 15 12:05:34 deepblue plasma_session[551]: org.kde.plasma.session: Start=
ing autostart service  "/etc/xdg/autostart/pulseaudio.desktop" ("/usr/bin/s=
tart-pulseaudio-x11")
Nov 15 12:05:34 deepblue kaccess[618]: X server XKB extension major=3D 1  m=
inor=3D 0
Nov 15 12:05:34 deepblue dbus-daemon[543]: [session uid=3D1000 pid=3D543] A=
ctivating service name=3D'ca.desrt.dconf' requested by ':1.19' (uid=3D1000 =
pid=3D645 comm=3D"/usr/bin/gsettings set org.gnome.desktop.a11y.appl")
Nov 15 12:05:34 deepblue dbus-daemon[543]: [session uid=3D1000 pid=3D543] S=
uccessfully activated service 'ca.desrt.dconf'
Nov 15 12:05:34 deepblue polkit-kde-authentication-agent-1[622]: New Polkit=
AgentListener  0x55c11f249400
Nov 15 12:05:34 deepblue polkit-kde-authentication-agent-1[622]: Adding new=
 listener  PolkitQt1::Agent::Listener(0x55c11f27f3f0) for  0x55c11f249400
Nov 15 12:05:34 deepblue polkit-kde-authentication-agent-1[622]: Listener o=
nline
Nov 15 12:05:34 deepblue polkitd[462]: Registered Authentication Agent for =
unix-session:c2 (system bus name :1.25 [/usr/lib/polkit-kde-authentication-=
agent-1], object path /org/kde/PolicyKit1/AuthenticationAgent, locale de_AT=
.UTF-8)
Nov 15 12:05:34 deepblue polkit-kde-authentication-agent-1[622]: Authentica=
tion agent result: true
Nov 15 12:05:34 deepblue iwd[304]: src/station.c:station_dbus_scan() Scan c=
alled from DBus
Nov 15 12:05:34 deepblue iwd[304]: src/wiphy.c:wiphy_radio_work_insert() In=
serting work item 4
Nov 15 12:05:34 deepblue iwd[304]: src/wiphy.c:wiphy_radio_work_next() Star=
ting work item 4
Nov 15 12:05:34 deepblue iwd[304]: src/scan.c:scan_notify() Scan notificati=
on Trigger Scan(33)
Nov 15 12:05:34 deepblue iwd[304]: src/scan.c:scan_request_triggered() Acti=
ve scan triggered for wdev 2
Nov 15 12:05:34 deepblue iwd[304]: src/station.c:station_dbus_scan_triggere=
d() station_scan_triggered: 0
Nov 15 12:05:34 deepblue iwd[304]: src/station.c:station_dbus_scan_triggere=
d() Scan triggered for wlan0
Nov 15 12:05:34 deepblue dbus-daemon[543]: [session uid=3D1000 pid=3D543] A=
ctivating service name=3D'org.freedesktop.Notifications' requested by ':1.2=
2' (uid=3D1000 pid=3D630 comm=3D"/usr/lib/kdeconnectd ")
Nov 15 12:05:34 deepblue kernel: logitech-hidpp-device 0003:046D:4055.0004:=
 HID++ 4.5 device connected.
Nov 15 12:05:34 deepblue plasmashell[612]: kf.plasma.quick: Applet preload =
policy set to 1
Nov 15 12:05:34 deepblue upowerd[481]: treating change event as add on /sys=
/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.2/0003:046D:C52B.0003/0003:=
046D:4055.0004/power_supply/hidpp_battery_1
Nov 15 12:05:34 deepblue dbus-daemon[303]: [system] Activating via systemd:=
 service name=3D'org.freedesktop.RealtimeKit1' unit=3D'rtkit-daemon.service=
' requested by ':1.28' (uid=3D1000 pid=3D638 comm=3D"/usr/bin/pulseaudio --=
daemonize=3Dno --log-target=3Djo")
Nov 15 12:05:34 deepblue dbus-daemon[303]: [system] Successfully activated =
service 'org.freedesktop.RealtimeKit1'
Nov 15 12:05:34 deepblue rtkit-daemon[669]: Successfully called chroot.
Nov 15 12:05:34 deepblue rtkit-daemon[669]: Successfully dropped privileges.
Nov 15 12:05:34 deepblue rtkit-daemon[669]: Successfully limited resources.
Nov 15 12:05:34 deepblue rtkit-daemon[669]: Running.
Nov 15 12:05:34 deepblue rtkit-daemon[669]: Canary thread running.
Nov 15 12:05:34 deepblue rtkit-daemon[669]: Watchdog thread running.
Nov 15 12:05:34 deepblue rtkit-daemon[669]: Successfully made thread 638 of=
 process 638 owned by '1000' high priority at nice level -11.
Nov 15 12:05:34 deepblue rtkit-daemon[669]: Supervising 1 threads of 1 proc=
esses of 1 users.
Nov 15 12:05:34 deepblue rtkit-daemon[669]: Supervising 1 threads of 1 proc=
esses of 1 users.
Nov 15 12:05:34 deepblue rtkit-daemon[669]: Successfully made thread 677 of=
 process 638 owned by '1000' RT at priority 5.
Nov 15 12:05:34 deepblue rtkit-daemon[669]: Supervising 2 threads of 1 proc=
esses of 1 users.
Nov 15 12:05:35 deepblue plasmashell[612]: Plasma Shell startup completed
Nov 15 12:05:35 deepblue dbus-daemon[543]: [session uid=3D1000 pid=3D543] S=
uccessfully activated service 'org.freedesktop.Notifications'
Nov 15 12:05:35 deepblue kded5[571]: Registering "org.kde.StatusNotifierHos=
t-612" as system tray
Nov 15 12:05:35 deepblue plasmashell[612]: Plasma Shell startup completed
Nov 15 12:05:35 deepblue plasmashell[612]: Plasma Shell startup completed
Nov 15 12:05:37 deepblue iwd[304]: src/scan.c:scan_notify() Scan notificati=
on New Scan Results(34)
Nov 15 12:05:37 deepblue iwd[304]: src/netdev.c:netdev_link_notify() event =
16 on ifindex 4
Nov 15 12:05:37 deepblue iwd[304]: src/scan.c:get_scan_callback() get_scan_=
callback
Nov 15 12:05:37 deepblue iwd[304]: src/scan.c:scan_parse_bss_information_el=
ements() Load: 9/255
Nov 15 12:05:37 deepblue iwd[304]: src/scan.c:get_scan_callback() get_scan_=
callback
Nov 15 12:05:37 deepblue iwd[304]: src/scan.c:scan_parse_bss_information_el=
ements() Load: 8/255
Nov 15 12:05:37 deepblue iwd[304]: src/scan.c:get_scan_callback() get_scan_=
callback
Nov 15 12:05:37 deepblue iwd[304]: src/scan.c:get_scan_callback() get_scan_=
callback
Nov 15 12:05:37 deepblue iwd[304]: src/scan.c:get_scan_callback() get_scan_=
callback
Nov 15 12:05:37 deepblue iwd[304]: src/scan.c:scan_parse_bss_information_el=
ements() Load: 23/255
Nov 15 12:05:37 deepblue iwd[304]: src/scan.c:get_scan_callback() get_scan_=
callback
Nov 15 12:05:37 deepblue iwd[304]: src/scan.c:scan_parse_bss_information_el=
ements() Load: 48/255
Nov 15 12:05:37 deepblue iwd[304]: src/scan.c:get_scan_callback() get_scan_=
callback
Nov 15 12:05:37 deepblue iwd[304]: src/scan.c:get_scan_callback() get_scan_=
callback
Nov 15 12:05:37 deepblue iwd[304]: src/scan.c:scan_parse_bss_information_el=
ements() Load: 1/255
Nov 15 12:05:37 deepblue iwd[304]: src/scan.c:get_scan_done() get_scan_done
Nov 15 12:05:37 deepblue iwd[304]: src/station.c:station_add_seen_bss() Pro=
cessing BSS 'cc:ce:1e:94:68:8c' with SSID: Pasithea, freq: 5220, rank: 9126=
, strength: -5400
Nov 15 12:05:37 deepblue iwd[304]: src/station.c:station_add_seen_bss() Pro=
cessing BSS 'cc:ce:1e:94:68:8b' with SSID: Pasithea, freq: 2462, rank: 4537=
, strength: -5100
Nov 15 12:05:37 deepblue iwd[304]: src/station.c:station_add_seen_bss() Pro=
cessing BSS '2c:fd:a1:3e:ac:2a' with SSID: Tritium, freq: 2412, rank: 2555,=
 strength: -6700
Nov 15 12:05:37 deepblue iwd[304]: src/station.c:station_add_seen_bss() Pro=
cessing BSS '2c:fd:a1:3e:ac:2c' with SSID: Tritium, freq: 5680, rank: 2499,=
 strength: -6900
Nov 15 12:05:37 deepblue iwd[304]: src/station.c:station_add_seen_bss() Pro=
cessing BSS '44:4e:6d:dd:b9:e7' with SSID: Pasithea, freq: 5220, rank: 1868=
, strength: -7900
Nov 15 12:05:37 deepblue iwd[304]: src/station.c:station_add_seen_bss() Pro=
cessing BSS 'e8:65:d4:93:60:11' with SSID: A1-1b7e51, freq: 2437, rank: 146=
8, strength: -8300
Nov 15 12:05:37 deepblue iwd[304]: src/station.c:station_add_seen_bss() Add=
ed new Network "A1-1b7e51" security psk
Nov 15 12:05:37 deepblue iwd[304]: src/station.c:station_add_seen_bss() Pro=
cessing BSS '44:4e:6d:dd:b9:e8' with SSID: Pasithea, freq: 2462, rank: 1468=
, strength: -8300
Nov 15 12:05:37 deepblue iwd[304]: src/station.c:station_add_seen_bss() Pro=
cessing BSS '06:0e:3c:5f:a8:ab' with SSID: DIRECT-AB-HP OfficeJet 5200, fre=
q: 2412, rank: 1224, strength: -8300
Nov 15 12:05:37 deepblue iwd[304]: src/wiphy.c:wiphy_radio_work_done() Work=
 item 4 done
Nov 15 12:05:42 deepblue systemd[441]: pam_warn(systemd-user:setcred): func=
tion=3D[pam_sm_setcred] flags=3D0x8004 service=3D[systemd-user] terminal=3D=
[] user=3D[sddm] ruser=3D[<unknown>] rhost=3D[<unknown>]
Nov 15 12:05:44 deepblue iwd[304]: src/station.c:station_dbus_scan() Scan c=
alled from DBus
Nov 15 12:05:44 deepblue iwd[304]: src/wiphy.c:wiphy_radio_work_insert() In=
serting work item 5
Nov 15 12:05:44 deepblue iwd[304]: src/wiphy.c:wiphy_radio_work_next() Star=
ting work item 5
Nov 15 12:05:44 deepblue iwd[304]: src/scan.c:scan_notify() Scan notificati=
on Trigger Scan(33)
Nov 15 12:05:44 deepblue iwd[304]: src/scan.c:scan_request_triggered() Acti=
ve scan triggered for wdev 2
Nov 15 12:05:44 deepblue iwd[304]: src/station.c:station_dbus_scan_triggere=
d() station_scan_triggered: 0
Nov 15 12:05:44 deepblue iwd[304]: src/station.c:station_dbus_scan_triggere=
d() Scan triggered for wlan0
--===============6775146338385946399==--

