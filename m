Content-Type: multipart/mixed; boundary="===============1734947135391738707=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: question on failed tests
Date: Wed, 09 Sep 2020 10:47:46 -0500
Message-ID: <CAG17S_O16b0dSS37LziJ2EuhUoyhBOYEGRjHqX4Hb09Y0A5k5A@mail.gmail.com>
In-Reply-To: <907a6d62-215e-376a-34a7-e30084ad7bb4@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1734947135391738707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis,

I am running 5.4.61. I made 2 edits to the config file. Rebuilding and will
see how it goes. The script has some config settings which are a bit
different on ARM.

Thanks,

Keith

On Wed, Sep 9, 2020 at 9:45 AM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Keith,
>
> On 9/9/20 9:10 AM, KeithG wrote:
> > I just built the iwd 1.9 for arch arm on armv6h, armv7h, and aarch64.
> The aarch
> > 64 builds and fails 0 tests. The armv6 fails the crypto and eapol tests
> and the
> > armv7 fails the eapol test.
>
> What kernels are running on these systems?
>
> Note that Linux Kernel 5.8.4 or so had a regression in the crypto
> subsystem
> which would result in a failure in the way iwd/ell used the AF_ALG API.
> This
> was patched shortly after.  You can upgrade, downgrade or backport the fix
> [1]
>
> > Which kernel configs do I need to enable so that iwd fails 0 tests on
> all 3
> > architectures?
> > I searched the kernel configs for 'eapol' and found nothing. The
> 'crypto' search
> > revealed a lot of settings, but all looked to be either 'm'  or 'y'. I
> am a bit
> > out of my depth, here but i'm capable of building kernels for all 3
> > architectures. Thanks for any guidance.
>
> This script should have all the kernel options required for crypto (3rd
> section
> from the top, starting at line 12):
>
>
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/tools/test_r=
unner_kernel_config#n12
>
> [1]
>
> https://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git/co=
mmit/?id=3Dc195d66a8a75c60515819b101975f38b7ec6577f
>
> Regards,
> -Denis
>

--===============1734947135391738707==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5EZW5pcyw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgYW0g
cnVubmluZyA1LjQuNjEuIEkgbWFkZSAyIGVkaXRzIHRvIHRoZSBjb25maWcgZmlsZS4gUmVidWls
ZGluZyBhbmQgd2lsbCBzZWUgaG93IGl0IGdvZXMuIFRoZSBzY3JpcHQgaGFzIHNvbWUgY29uZmln
IHNldHRpbmdzIHdoaWNoIGFyZSBhIGJpdCBkaWZmZXJlbnQgb24gQVJNLjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+VGhhbmtzLDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+S2VpdGg8YnI+PC9k
aXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFz
cz0iZ21haWxfYXR0ciI+T24gV2VkLCBTZXAgOSwgMjAyMCBhdCA5OjQ1IEFNIERlbmlzIEtlbnpp
b3IgJmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsi
PmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNs
YXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXIt
bGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBLZWl0
aCw8YnI+Cjxicj4KT24gOS85LzIwIDk6MTAgQU0sIEtlaXRoRyB3cm90ZTo8YnI+CiZndDsgSSBq
dXN0IGJ1aWx0IHRoZSBpd2QgMS45IGZvciBhcmNoIGFybSBvbiBhcm12NmgsIGFybXY3aCwgYW5k
IGFhcmNoNjQuIFRoZSBhYXJjaCA8YnI+CiZndDsgNjQgYnVpbGRzIGFuZCBmYWlscyAwIHRlc3Rz
LiBUaGUgYXJtdjYgZmFpbHMgdGhlIGNyeXB0byBhbmQgZWFwb2wgdGVzdHMgYW5kIHRoZSA8YnI+
CiZndDsgYXJtdjcgZmFpbHMgdGhlIGVhcG9sIHRlc3QuPGJyPgo8YnI+CldoYXQga2VybmVscyBh
cmUgcnVubmluZyBvbiB0aGVzZSBzeXN0ZW1zPzxicj4KPGJyPgpOb3RlIHRoYXQgTGludXggS2Vy
bmVsIDUuOC40IG9yIHNvIGhhZCBhIHJlZ3Jlc3Npb24gaW4gdGhlIGNyeXB0byBzdWJzeXN0ZW0g
PGJyPgp3aGljaCB3b3VsZCByZXN1bHQgaW4gYSBmYWlsdXJlIGluIHRoZSB3YXkgaXdkL2VsbCB1
c2VkIHRoZSBBRl9BTEcgQVBJLsKgIFRoaXMgPGJyPgp3YXMgcGF0Y2hlZCBzaG9ydGx5IGFmdGVy
LsKgIFlvdSBjYW4gdXBncmFkZSwgZG93bmdyYWRlIG9yIGJhY2twb3J0IHRoZSBmaXggWzFdPGJy
Pgo8YnI+CiZndDsgV2hpY2gga2VybmVsIGNvbmZpZ3MgZG8gSSBuZWVkIHRvIGVuYWJsZSBzbyB0
aGF0IGl3ZCBmYWlscyAwIHRlc3RzIG9uIGFsbCAzIDxicj4KJmd0OyBhcmNoaXRlY3R1cmVzPzxi
cj4KJmd0OyBJIHNlYXJjaGVkIHRoZSBrZXJuZWwgY29uZmlncyBmb3IgJiMzOTtlYXBvbCYjMzk7
IGFuZCBmb3VuZCBub3RoaW5nLiBUaGUgJiMzOTtjcnlwdG8mIzM5OyBzZWFyY2ggPGJyPgomZ3Q7
IHJldmVhbGVkIGEgbG90IG9mIHNldHRpbmdzLCBidXQgYWxsIGxvb2tlZCB0byBiZSBlaXRoZXIg
JiMzOTttJiMzOTvCoCBvciAmIzM5O3kmIzM5Oy4gSSBhbSBhIGJpdCA8YnI+CiZndDsgb3V0IG9m
IG15IGRlcHRoLCBoZXJlIGJ1dCBpJiMzOTttIGNhcGFibGUgb2YgYnVpbGRpbmcga2VybmVscyBm
b3IgYWxsIDMgPGJyPgomZ3Q7IGFyY2hpdGVjdHVyZXMuIFRoYW5rcyBmb3IgYW55IGd1aWRhbmNl
Ljxicj4KPGJyPgpUaGlzIHNjcmlwdCBzaG91bGQgaGF2ZSBhbGwgdGhlIGtlcm5lbCBvcHRpb25z
IHJlcXVpcmVkIGZvciBjcnlwdG8gKDNyZCBzZWN0aW9uIDxicj4KZnJvbSB0aGUgdG9wLCBzdGFy
dGluZyBhdCBsaW5lIDEyKTo8YnI+Cjxicj4KPGEgaHJlZj0iaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL25ldHdvcmsvd2lyZWxlc3MvaXdkLmdpdC90cmVlL3Rvb2xzL3Rlc3RfcnVubmVy
X2tlcm5lbF9jb25maWcjbjEyIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbmV0d29yay93aXJlbGVzcy9pd2QuZ2l0L3RyZWUv
dG9vbHMvdGVzdF9ydW5uZXJfa2VybmVsX2NvbmZpZyNuMTI8L2E+PGJyPgo8YnI+ClsxXSA8YnI+
CjxhIGhyZWY9Imh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L2hlcmJlcnQvY3J5cHRvLTIuNi5naXQvY29tbWl0Lz9pZD1jMTk1ZDY2YThhNzVjNjA1MTU4MTli
MTAxOTc1ZjM4YjdlYzY1NzdmIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9oZXJiZXJ0L2NyeXB0
by0yLjYuZ2l0L2NvbW1pdC8/aWQ9YzE5NWQ2NmE4YTc1YzYwNTE1ODE5YjEwMTk3NWYzOGI3ZWM2
NTc3ZjwvYT48YnI+Cjxicj4KUmVnYXJkcyw8YnI+Ci1EZW5pczxicj4KPC9ibG9ja3F1b3RlPjwv
ZGl2Pgo=

--===============1734947135391738707==--

