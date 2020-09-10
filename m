Content-Type: multipart/mixed; boundary="===============3310636922854979007=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: question on failed tests
Date: Wed, 09 Sep 2020 22:26:44 -0500
Message-ID: <CAG17S_MekoU62j2LhNq_0wrn3Tnfa1vNPUYAkLPXHEB=nM0UQQ@mail.gmail.com>
In-Reply-To: <decb9567-4e29-1ea5-a5a0-0038b213a930@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3310636922854979007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2020 at 8:18 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Keith,
>
> No top-posting please :)
>
> On 9/9/20 7:48 PM, KeithG wrote:
> > Denis,
> >
> > I built the kernel and tried building it again. This time I get 2 errors
> on armv7:
> >    CC       unit/test-crypto.o
> >    CCLD     unit/test-crypto
> > ./build-aux/test-driver: line 107:  9846 Aborted                 (core
> dumped) "
> >                               $@" > $log_file 2>&1
> > FAIL: unit/test-crypto
> > ...
> >    CC       unit/test-wsc.o
> >    CCLD     unit/test-wsc
> > ./build-aux/test-driver: line 107: 10643 Aborted                 (core
> dumped) "
> >                               $@" > $log_file 2>&1
> > FAIL: unit/test-wsc
> >
>
> Can you provide unit/test-crypto.log and unit/test-wsc.log from these
> systems?
>
> Also, can you run strace on both manually and provide logs from that?
>
> > The intel and arm stuff differs and some of the keys are not present. I
> do not
> > know if I should brute them in there. The config I used is attached.
> This is on
> > a RaspberryPi4 running this kernel 5.4.61-2 armv7h
>
> CONFIG_KEY_DH_OPERATIONS is required for WPS/P2P support.
>
> CONFIG_PKCS8_PRIVATE_KEY_PARSER is required for EAP-TLS.
>
> Regards,
> -Denis
>
Denis:

I had both of those kernel configs set to '=3Dy'

The logs.
test-crypto.log:
test-crypto: unit/test-crypto.c:397: aes_siv_test: Assertion
`aes_siv_encrypt(key, sizeof(key), plaintext, sizeof(plaintext), iov, 1,
outbuf)' failed.
FAIL unit/test-crypto (exit status: 134)
test-wsc.log:
test-wsc: unit/test-wsc.c:1993: verify_8021x: Assertion `len =3D=3D
data->expected_len' failed.
FAIL unit/test-wsc (exit status: 134)

Can you give me some guidance on how to provide an strace?
Keith

--===============3310636922854979007==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFdlZCwgU2Vw
IDksIDIwMjAgYXQgODoxOCBQTSBEZW5pcyBLZW56aW9yICZsdDs8YSBocmVmPSJtYWlsdG86ZGVu
a2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2
PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBw
eCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxl
ZnQ6MWV4Ij5IaSBLZWl0aCw8YnI+Cjxicj4KTm8gdG9wLXBvc3RpbmcgcGxlYXNlIDopPGJyPgo8
YnI+Ck9uIDkvOS8yMCA3OjQ4IFBNLCBLZWl0aEcgd3JvdGU6PGJyPgomZ3Q7IERlbmlzLDxicj4K
Jmd0OyA8YnI+CiZndDsgSSBidWlsdCB0aGUga2VybmVsIGFuZCB0cmllZCBidWlsZGluZyBpdCBh
Z2Fpbi4gVGhpcyB0aW1lIEkgZ2V0IDIgZXJyb3JzIG9uIGFybXY3Ojxicj4KJmd0O8KgIMKgIEND
IMKgIMKgIMKgIHVuaXQvdGVzdC1jcnlwdG8ubzxicj4KJmd0O8KgIMKgIENDTEQgwqAgwqAgdW5p
dC90ZXN0LWNyeXB0bzxicj4KJmd0OyAuL2J1aWxkLWF1eC90ZXN0LWRyaXZlcjogbGluZSAxMDc6
IMKgOTg0NiBBYm9ydGVkIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIChjb3JlIGR1bXBlZCkgJnF1
b3Q7IDxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgJEAmcXVvdDsgJmd0OyAkbG9nX2ZpbGUgMiZndDsmYW1wOzE8YnI+CiZndDsgRkFJTDogdW5p
dC90ZXN0LWNyeXB0bzxicj4KJmd0OyAuLi48YnI+CiZndDvCoCDCoCBDQyDCoCDCoCDCoCB1bml0
L3Rlc3Qtd3NjLm88YnI+CiZndDvCoCDCoCBDQ0xEIMKgIMKgIHVuaXQvdGVzdC13c2M8YnI+CiZn
dDsgLi9idWlsZC1hdXgvdGVzdC1kcml2ZXI6IGxpbmUgMTA3OiAxMDY0MyBBYm9ydGVkIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIChjb3JlIGR1bXBlZCkgJnF1b3Q7IDxicj4KJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJEAmcXVvdDsgJmd0OyAkbG9n
X2ZpbGUgMiZndDsmYW1wOzE8YnI+CiZndDsgRkFJTDogdW5pdC90ZXN0LXdzYzxicj4KJmd0OyA8
YnI+Cjxicj4KQ2FuIHlvdSBwcm92aWRlIHVuaXQvdGVzdC1jcnlwdG8ubG9nIGFuZCB1bml0L3Rl
c3Qtd3NjLmxvZyBmcm9tIHRoZXNlIHN5c3RlbXM/PGJyPgo8YnI+CkFsc28sIGNhbiB5b3UgcnVu
IHN0cmFjZSBvbiBib3RoIG1hbnVhbGx5IGFuZCBwcm92aWRlIGxvZ3MgZnJvbSB0aGF0Pzxicj4K
PGJyPgomZ3Q7IFRoZSBpbnRlbCBhbmQgYXJtIHN0dWZmIGRpZmZlcnMgYW5kIHNvbWUgb2YgdGhl
IGtleXMgYXJlIG5vdCBwcmVzZW50LiBJIGRvIG5vdCA8YnI+CiZndDsga25vdyBpZiBJIHNob3Vs
ZCBicnV0ZSB0aGVtIGluIHRoZXJlLiBUaGUgY29uZmlnIEkgdXNlZCBpcyBhdHRhY2hlZC4gVGhp
cyBpcyBvbiA8YnI+CiZndDsgYSBSYXNwYmVycnlQaTQgcnVubmluZyB0aGlzIGtlcm5lbCA1LjQu
NjEtMiBhcm12N2g8YnI+Cjxicj4KQ09ORklHX0tFWV9ESF9PUEVSQVRJT05TIGlzIHJlcXVpcmVk
IGZvciBXUFMvUDJQIHN1cHBvcnQuPGJyPgo8YnI+CkNPTkZJR19QS0NTOF9QUklWQVRFX0tFWV9Q
QVJTRVIgaXMgcmVxdWlyZWQgZm9yIEVBUC1UTFMuPGJyPgo8YnI+ClJlZ2FyZHMsPGJyPgotRGVu
aXM8YnI+PC9ibG9ja3F1b3RlPjxkaXY+RGVuaXM6PC9kaXY+PGRpdj4gPGJyPjwvZGl2PjxkaXY+
SSBoYWQgYm90aCBvZiB0aG9zZSBrZXJuZWwgY29uZmlncyBzZXQgdG8gJiMzOTs9eSYjMzk7PC9k
aXY+PGRpdj4gPGJyPjwvZGl2PjxkaXY+VGhlIGxvZ3MuPC9kaXY+PGRpdj50ZXN0LWNyeXB0by5s
b2c6PC9kaXY+PGRpdj50ZXN0LWNyeXB0bzogdW5pdC90ZXN0LWNyeXB0by5jOjM5NzogYWVzX3Np
dl90ZXN0OiBBc3NlcnRpb24gYGFlc19zaXZfZW5jcnlwdChrZXksIHNpemVvZihrZXkpLCBwbGFp
bnRleHQsIHNpemVvZihwbGFpbnRleHQpLCBpb3YsIDEsIG91dGJ1ZikmIzM5OyBmYWlsZWQuPGJy
PkZBSUwgdW5pdC90ZXN0LWNyeXB0byAoZXhpdCBzdGF0dXM6IDEzNCk8L2Rpdj48ZGl2PnRlc3Qt
d3NjLmxvZzo8L2Rpdj48ZGl2PnRlc3Qtd3NjOiB1bml0L3Rlc3Qtd3NjLmM6MTk5MzogdmVyaWZ5
XzgwMjF4OiBBc3NlcnRpb24gYGxlbiA9PSBkYXRhLSZndDtleHBlY3RlZF9sZW4mIzM5OyBmYWls
ZWQuPGJyPkZBSUwgdW5pdC90ZXN0LXdzYyAoZXhpdCBzdGF0dXM6IDEzNCk8L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PkNhbiB5b3UgZ2l2ZSBtZSBzb21lIGd1aWRhbmNlIG9uIGhvdyB0byBwcm92
aWRlIGFuIHN0cmFjZT88YnI+PC9kaXY+PGRpdj5LZWl0aDxicj4gPC9kaXY+PC9kaXY+PC9kaXY+
Cg==

--===============3310636922854979007==--

