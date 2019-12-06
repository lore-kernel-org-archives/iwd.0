Content-Type: multipart/mixed; boundary="===============4667338231923331697=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] station: add dependency to device
Date: Fri, 06 Dec 2019 10:27:29 -0600
Message-ID: <bf1b2b10-5b85-8231-cdf8-d554889eb2a5@gmail.com>
In-Reply-To: <20191206055606.24914-1-Etrnls@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4667338231923331697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On 12/5/19 11:56 PM, Shuai Wang wrote:
> scan_periodic_start triggered by station requires scan_wdev_add to be
> called first from device.
> ---
>   src/station.c | 1 +
>   1 file changed, 1 insertion(+)
> =


Thanks for the bug report & fix.  Looks like commit 1057d8aa743a =

("device: Move device creation from netdev.c to event watch")
introduced this regression.

> diff --git a/src/station.c b/src/station.c
> index c6029423..fd346194 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -3225,3 +3225,4 @@ static void station_exit(void)
>   =

>   IWD_MODULE(station, station_init, station_exit)
>   IWD_MODULE_DEPENDS(station, netconfig)
> +IWD_MODULE_DEPENDS(station, device)
> =


Module dependencies are only really needed if one module _init function =

uses functionality (like event watch registrations, etc) from another =

module at daemon startup time.  For this case the fix is a bit different.

Could you try the attached patch instead?

Regards,
-Denis

--===============4667338231923331697==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-device-netdev-init-scan-in-netdev-instead-of-device.patch"

RnJvbSA3MzgxODRkNDkxNjc1OTAzOTU0MzllZDY3N2M5M2RiOGI1ODYzOWFjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEZW5pcyBLZW56aW9yIDxkZW5rZW56QGdtYWlsLmNvbT4KRGF0
ZTogRnJpLCA2IERlYyAyMDE5IDEwOjExOjUxIC0wNjAwClN1YmplY3Q6IFtQQVRDSF0gZGV2aWNl
L25ldGRldjogaW5pdCBzY2FuIGluIG5ldGRldiBpbnN0ZWFkIG9mIGRldmljZQoKQ29tbWl0IDEw
NTdkOGFhNzQzYSBjaGFuZ2VkIHRoZSBkZXZpY2UgaW50ZXJmYWNlIGNyZWF0aW9uIGxvZ2ljCmZy
b20gYmVpbmcgdW5jb25kaXRpb25hbCBpbnNpZGUgbmV0ZGV2LmMgdG8gaW5zdGVhZCB1c2UgTkVU
REVWX1dBVENIXyoKZXZlbnRzLiAgSG93ZXZlciwgdGhpcyBicm9rZSB0aGUgYXNzdW1wdGlvbiB0
aGF0IHRoZSBkZXZpY2UgaW50ZXJmYWNlCndhcyBjcmVhdGVkIGJlZm9yZSBhbGwgb3RoZXJzLiAg
VGhlIGVmZmVjdCBpcyB0aGF0IHRoZSBzY2FuX3dkZXZfYWRkCm1pZ2h0IG5vIGxvbmdlciBiZSBj
YWxsZWQgcHJpb3IgdG8gc3RhdGlvbiBpbnRlcmZhY2UgYmVpbmcgY3JlYXRlZC4gIEZpeAp0aGlz
IGJ5IG1vdmluZyBzY2FuX3dkZXZfYWRkL3JlbW92ZSBjYWxscyB0byBuZXRkZXYuYyBpbnN0ZWFk
LgoKRml4ZXM6IDEwNTdkOGFhNzQzYSAoImRldmljZTogTW92ZSBkZXZpY2UgY3JlYXRpb24gZnJv
bSBuZXRkZXYuYyB0byBldmVudCB3YXRjaCIpCi0tLQogc3JjL2RldmljZS5jIHwgNCAtLS0tCiBz
cmMvbmV0ZGV2LmMgfCA0ICsrKysKIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9kZXZpY2UuYyBiL3NyYy9kZXZpY2UuYwpp
bmRleCAzZWQzOTYxOTIwYmUuLjBhZDFjY2JmYzgwOSAxMDA2NDQKLS0tIGEvc3JjL2RldmljZS5j
CisrKyBiL3NyYy9kZXZpY2UuYwpAQCAtMzIyLDggKzMyMiw2IEBAIHN0YXRpYyBzdHJ1Y3QgZGV2
aWNlICpkZXZpY2VfY3JlYXRlKHN0cnVjdCB3aXBoeSAqd2lwaHksIHN0cnVjdCBuZXRkZXYgKm5l
dGRldikKIAkJbF9pbmZvKCJVbmFibGUgdG8gcmVnaXN0ZXIgJXMgaW50ZXJmYWNlIiwKIAkJCQlM
X0RCVVNfSU5URVJGQUNFX1BST1BFUlRJRVMpOwogCi0Jc2Nhbl93ZGV2X2FkZChuZXRkZXZfZ2V0
X3dkZXZfaWQoZGV2aWNlLT5uZXRkZXYpKTsKLQogCS8qCiAJICogcmVnaXN0ZXIgZm9yIEFQIHJv
YW0gdHJhbnNpdGlvbiB3YXRjaAogCSAqLwpAQCAtMzQ1LDggKzM0Myw2IEBAIHN0YXRpYyB2b2lk
IGRldmljZV9mcmVlKHN0cnVjdCBkZXZpY2UgKmRldmljZSkKIHsKIAlsX2RlYnVnKCIiKTsKIAot
CXNjYW5fd2Rldl9yZW1vdmUobmV0ZGV2X2dldF93ZGV2X2lkKGRldmljZS0+bmV0ZGV2KSk7Ci0K
IAluZXRkZXZfZnJhbWVfd2F0Y2hfcmVtb3ZlKGRldmljZS0+bmV0ZGV2LCBkZXZpY2UtPmFwX3Jv
YW1fd2F0Y2gpOwogCXdpcGh5X3N0YXRlX3dhdGNoX3JlbW92ZShkZXZpY2UtPndpcGh5LCBkZXZp
Y2UtPndpcGh5X3Jma2lsbF93YXRjaCk7CiAKZGlmZiAtLWdpdCBhL3NyYy9uZXRkZXYuYyBiL3Ny
Yy9uZXRkZXYuYwppbmRleCBhZjY1NWM4NDJkNjUuLmQ5NmVlNzYwYzcxYSAxMDA2NDQKLS0tIGEv
c3JjL25ldGRldi5jCisrKyBiL3NyYy9uZXRkZXYuYwpAQCAtNjI2LDYgKzYyNiw4IEBAIHN0YXRp
YyB2b2lkIG5ldGRldl9mcmVlKHZvaWQgKmRhdGEpCiAJCVdBVENITElTVF9OT1RJRlkoJm5ldGRl
dl93YXRjaGVzLCBuZXRkZXZfd2F0Y2hfZnVuY190LAogCQkJCQluZXRkZXYsIE5FVERFVl9XQVRD
SF9FVkVOVF9ERUwpOwogCisJc2Nhbl93ZGV2X3JlbW92ZShuZXRkZXYtPndkZXZfaWQpOworCiAJ
d2F0Y2hsaXN0X2Rlc3Ryb3koJm5ldGRldi0+ZnJhbWVfd2F0Y2hlcyk7CiAJd2F0Y2hsaXN0X2Rl
c3Ryb3koJm5ldGRldi0+c3RhdGlvbl93YXRjaGVzKTsKIApAQCAtNDIwNCw2ICs0MjA2LDggQEAg
c3RhdGljIHZvaWQgbmV0ZGV2X2luaXRpYWxfdXBfY2IoaW50IGVycm9yLCB1aW50MTZfdCB0eXBl
LCBjb25zdCB2b2lkICpkYXRhLAogCiAJbF9kZWJ1ZygiSW50ZXJmYWNlICVpIGluaXRpYWxpemVk
IiwgbmV0ZGV2LT5pbmRleCk7CiAKKwlzY2FuX3dkZXZfYWRkKG5ldGRldi0+d2Rldl9pZCk7CisK
IAlXQVRDSExJU1RfTk9USUZZKCZuZXRkZXZfd2F0Y2hlcywgbmV0ZGV2X3dhdGNoX2Z1bmNfdCwK
IAkJCQluZXRkZXYsIE5FVERFVl9XQVRDSF9FVkVOVF9ORVcpOwogCW5ldGRldi0+ZXZlbnRzX3Jl
YWR5ID0gdHJ1ZTsKLS0gCjIuMjEuMAoK

--===============4667338231923331697==--

