Content-Type: multipart/mixed; boundary="===============3873155005738124312=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Interface not detected sometimes
Date: Wed, 05 Feb 2020 09:19:37 -0600
Message-ID: <5bf91f75-9c0a-6d87-761a-774c87f5f69d@gmail.com>
In-Reply-To: <20200205133515.2820.50222@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3873155005738124312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Hector,

On 2/5/20 7:35 AM, hector(a)ikatu.com wrote:
> Here is a log of a failed initialization where I have set "--interfaces w=
lan0", no sleep in iwd.service, and I applied your recent commit (8530396fb=
3179c789430264a01e506a11907f94b manager: Add brcmfmac to the blacklist), (B=
TW I didn't set any value to the UseDefaultInterface property).

Okay.  The brcmfmac commit shouldn't have any effect if you're using =

--interfaces command line option.  But it won't hurt.

<snip>

> Feb 05 13:24:33 Paris-00100105 iwd[429]: Wiphy: 0, Name: phy0
> Feb 05 13:24:33 Paris-00100105 iwd[429]:         Permanent Address: 10:98=
:c3:ff:f6:9d
> Feb 05 13:24:33 Paris-00100105 iwd[429]:         Bands: 2.4 GHz 5 GHz
> Feb 05 13:24:33 Paris-00100105 iwd[429]:         Ciphers: CCMP TKIP BIP
> Feb 05 13:24:33 Paris-00100105 iwd[429]:         Supported iftypes: ad-ho=
c station ap p2p-client p2p-go p2p-device
> Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_use=
_default()
> Feb 05 13:24:33 Paris-00100105 iwd[429]: No default interface for wiphy 0
> Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_con=
fig_notify() Notification of command New Interface(7)

Okay.  Looks like commit 55f9639ee37c ("manager: Retry the interface =

setup if we get an EBUSY") didn't address the 'use default' path.  Can =

you try the attach patch?

Regards,
-Denis

--===============3873155005738124312==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-manager-Also-set-retry-when-using-default-interfaces.patch"

RnJvbSAzNjBmNjZmNzFjYjE4N2QyNzhmNGRkNzVhY2MxZjcxZTQwODZmOTc4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEZW5pcyBLZW56aW9yIDxkZW5rZW56QGdtYWlsLmNvbT4KRGF0
ZTogV2VkLCA1IEZlYiAyMDIwIDA5OjE0OjQ3IC0wNjAwClN1YmplY3Q6IFtQQVRDSF0gbWFuYWdl
cjogQWxzbyBzZXQgcmV0cnkgd2hlbiB1c2luZyBkZWZhdWx0IGludGVyZmFjZXMKCi0tLQogc3Jj
L21hbmFnZXIuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0t
Z2l0IGEvc3JjL21hbmFnZXIuYyBiL3NyYy9tYW5hZ2VyLmMKaW5kZXggYTgxMGVkNzgxM2U4Li41
Y2E1ZDYxMDEzOGYgMTAwNjQ0Ci0tLSBhL3NyYy9tYW5hZ2VyLmMKKysrIGIvc3JjL21hbmFnZXIu
YwpAQCAtMTEyLDYgKzExMiw3IEBAIHN0YXRpYyBib29sIG1hbmFnZXJfdXNlX2RlZmF1bHQoc3Ry
dWN0IHdpcGh5X3NldHVwX3N0YXRlICpzdGF0ZSkKIAlpZiAoIXN0YXRlLT5kZWZhdWx0X2lmX21z
ZykgewogCQlsX2Vycm9yKCJObyBkZWZhdWx0IGludGVyZmFjZSBmb3Igd2lwaHkgJXUiLAogCQkJ
KHVuc2lnbmVkIGludCkgc3RhdGUtPmlkKTsKKwkJc3RhdGUtPnJldHJ5ID0gdHJ1ZTsKIAkJcmV0
dXJuIGZhbHNlOwogCX0KIAotLSAKMi4yMS4wCgo=

--===============3873155005738124312==--

