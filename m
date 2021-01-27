Content-Type: multipart/mixed; boundary="===============2735965274524766662=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: iwd 1.11 does not run on armv6
Date: Wed, 27 Jan 2021 01:32:41 -0600
Message-ID: <CAG17S_M2USaq-mopULODvN-0D14rxpQwaQtOq_VGYqBDToGTmQ@mail.gmail.com>
In-Reply-To: <CAG17S_PFA04=YujYMtkpB1CzXB+tvjcqPuvtAhEqyMwqa8AfRQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2735965274524766662==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I got it. ell is now external and that needed to be updated as well. Once I
did that, all is well, again.

On Wed, Jan 27, 2021 at 12:54 AM KeithG <ys3al35l@gmail.com> wrote:

> This is on Arch Arm on an RPi. 1.10 ran fine. 1.11 was just pushed out and
> now it does not run and we get this in the log:
> iwd[1770]: /usr/lib/iwd/iwd: symbol lookup error: /usr/lib/iwd/iwd:
> undefined symbol: l_acd_set_debug, version ELL_0.10
> in the log. Any ideas on how we can fix it? Is it a kernel flag that is
> somehow different between armv7 and armv6 versus aarch64?
>
> Keith
>

--===============2735965274524766662==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+SSBnb3QgaXQuIGVsbCBpcyBub3cgZXh0ZXJuYWwgYW5kIHRoYXQgbmVl
ZGVkIHRvIGJlIHVwZGF0ZWQgYXMgd2VsbC4gT25jZSBJIGRpZCB0aGF0LCBhbGwgaXMgd2VsbCwg
YWdhaW4uPGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0
ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFdlZCwgSmFuIDI3LCAyMDIxIGF0IDEyOjU0IEFNIEtl
aXRoRyAmbHQ7PGEgaHJlZj0ibWFpbHRvOnlzM2FsMzVsQGdtYWlsLmNvbSI+eXMzYWwzNWxAZ21h
aWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9x
dW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29s
aWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2
PlRoaXMgaXMgb24gQXJjaCBBcm0gb24gYW4gUlBpLiAxLjEwIHJhbiBmaW5lLiAxLjExIHdhcyBq
dXN0IHB1c2hlZCBvdXQgYW5kIG5vdyBpdCBkb2VzIG5vdCBydW4gYW5kIHdlIGdldCB0aGlzIGlu
IHRoZSBsb2c6PC9kaXY+PGRpdj5pd2RbMTc3MF06IC91c3IvbGliL2l3ZC9pd2Q6IHN5bWJvbCBs
b29rdXAgZXJyb3I6IC91c3IvbGliL2l3ZC9pd2Q6IHVuZGVmaW5lZCBzeW1ib2w6IGxfYWNkX3Nl
dF9kZWJ1ZywgdmVyc2lvbiBFTExfMC4xMDwvZGl2PjxkaXY+aW4gdGhlIGxvZy4gQW55IGlkZWFz
IG9uIGhvdyB3ZSBjYW4gZml4IGl0PyBJcyBpdCBhIGtlcm5lbCBmbGFnIHRoYXQgaXMgc29tZWhv
dyBkaWZmZXJlbnQgYmV0d2VlbiBhcm12NyBhbmQgYXJtdjYgdmVyc3VzIGFhcmNoNjQ/PC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5LZWl0aDxicj48L2Rpdj48L2Rpdj4KPC9ibG9ja3F1b3RlPjwv
ZGl2Pgo=

--===============2735965274524766662==--

