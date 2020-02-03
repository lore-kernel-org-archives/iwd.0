Content-Type: multipart/mixed; boundary="===============8040840141377762455=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] wiphy: Relpace rawmemchr with memchr
Date: Mon, 03 Feb 2020 11:55:43 -0600
Message-ID: <f89b63ef-cfe5-d950-c1a0-f3eaaab4fe4c@gmail.com>
In-Reply-To: <20200201075329.731645-1-robert.joslyn@redrectangle.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8040840141377762455==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robert,

On 2/1/20 1:53 AM, Robert Joslyn wrote:
> The rawmemchr function is a GNU extension, and not available in other
> libc implementations, such as musl.
> ---
>   src/wiphy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/src/wiphy.c b/src/wiphy.c
> index 1da479db..141b3cb9 100644
> --- a/src/wiphy.c
> +++ b/src/wiphy.c
> @@ -500,7 +500,7 @@ const uint8_t *wiphy_get_supported_rates(struct wiphy=
 *wiphy, unsigned int band,
>   =

>   	if (out_num)
>   		*out_num =3D
> -			(uint8_t *) rawmemchr(wiphy->supported_rates[band], 0) -
> +			(uint8_t *) memchr(wiphy->supported_rates[band], 0, (size_t)-1) -
>   			wiphy->supported_rates[band];
>   =

>   	return wiphy->supported_rates[band];
> =


Unfortunately this causes gcc to complain:

src/wiphy.c: In function =E2=80=98wiphy_get_supported_rates=E2=80=99:
src/wiphy.c:503:16: error: =E2=80=98memchr=E2=80=99 specified size 18446744=
073709551615 =

exceeds maximum object size 9223372036854775807 [-Werror=3Dstringop-overflo=
w=3D]
   503 |    (uint8_t *) memchr(wiphy->supported_rates[band], 0, =

(size_t)-1) -
       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

can you try the attached patch instead?

Regards,
-Denis

--===============8040840141377762455==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-build-Support-missing-rawmemchr.patch"

RnJvbSBmY2RkZGYyYjcyNjQzOWUwNDk5OTI4NzhmOTBkYTYwNzQxNGExYTQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEZW5pcyBLZW56aW9yIDxkZW5rZW56QGdtYWlsLmNvbT4KRGF0
ZTogTW9uLCAzIEZlYiAyMDIwIDExOjU0OjI4IC0wNjAwClN1YmplY3Q6IFtQQVRDSF0gYnVpbGQ6
IFN1cHBvcnQgbWlzc2luZyByYXdtZW1jaHIKCi0tLQogY29uZmlndXJlLmFjICB8ICAxICsKIHNy
Yy9taXNzaW5nLmggfCAxMCArKysrKysrKysrCiBzcmMvd2lwaHkuYyAgIHwgIDEgKwogMyBmaWxl
cyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvY29uZmlndXJlLmFjIGIv
Y29uZmlndXJlLmFjCmluZGV4IDVhZTE0MDFjYWUxNy4uMmQzNzNhNDdiYTY4IDEwMDY0NAotLS0g
YS9jb25maWd1cmUuYWMKKysrIGIvY29uZmlndXJlLmFjCkBAIC0xMjgsNiArMTI4LDcgQEAgQUNf
REVGSU5FX1VOUVVPVEVEKFdJUkVEX1NUT1JBR0VESVIsICIke3dpcmVkX3N0b3JhZ2VkaXJ9IiwK
IAkJCVtEaXJlY3RvcnkgZm9yIEV0aGVybmV0IGRhZW1vbiBzdG9yYWdlIGZpbGVzXSkKIAogQUNf
Q0hFQ0tfRlVOQ1MoZXhwbGljaXRfYnplcm8pCitBQ19DSEVDS19GVU5DUyhyYXdtZW1jaHIpCiAK
IEFDX0NIRUNLX0hFQURFUlMobGludXgvdHlwZXMuaCBsaW51eC9pZl9hbGcuaCkKIApkaWZmIC0t
Z2l0IGEvc3JjL21pc3NpbmcuaCBiL3NyYy9taXNzaW5nLmgKaW5kZXggMmJiMjEwYWUzYzgxLi4y
Y2M4MGFlZTVkMzggMTAwNjQ0Ci0tLSBhL3NyYy9taXNzaW5nLmgKKysrIGIvc3JjL21pc3Npbmcu
aApAQCAtMjcsMyArMjcsMTMgQEAgc3RhdGljIGlubGluZSB2b2lkIGV4cGxpY2l0X2J6ZXJvKHZv
aWQgKnMsIHNpemVfdCBuKQogICAgICAgICBfX2FzbV9fIF9fdm9sYXRpbGVfXyAoIiIgOiA6ICJy
IihzKSA6ICJtZW1vcnkiKTsKIH0KICNlbmRpZgorCisjaWZuZGVmIEhBVkVfUkFXTUVNQ0hSCitz
dGF0aWMgaW5saW5lIHZvaWQgKnJhd21lbWNocihjb25zdCB2b2lkICpzLCBpbnQgYykKK3sKK19Q
cmFnbWEoIkdDQyBkaWFnbm9zdGljIHB1c2giKQorX1ByYWdtYSgiR0NDIGRpYWdub3N0aWMgaWdu
b3JlZCBcIi1Xc3RyaW5nb3Atb3ZlcmZsb3c9XCIiKQorCXJldHVybiBtZW1jaHIocywgYywgKHNp
emVfdCkgLTEpOworX1ByYWdtYSgiR0NDIGRpYWdub3N0aWMgcG9wIikKK30KKyNlbmRpZgpkaWZm
IC0tZ2l0IGEvc3JjL3dpcGh5LmMgYi9zcmMvd2lwaHkuYwppbmRleCAxZGE0NzlkYjJkYWIuLjUx
MWJiMjdmNTJiOCAxMDA2NDQKLS0tIGEvc3JjL3dpcGh5LmMKKysrIGIvc3JjL3dpcGh5LmMKQEAg
LTM3LDYgKzM3LDcgQEAKIAogI2luY2x1ZGUgImxpbnV4L25sODAyMTEuaCIKIAorI2luY2x1ZGUg
InNyYy9taXNzaW5nLmgiCiAjaW5jbHVkZSAic3JjL2l3ZC5oIgogI2luY2x1ZGUgInNyYy9tb2R1
bGUuaCIKICNpbmNsdWRlICJzcmMvaWUuaCIKLS0gCjIuMjEuMAoK

--===============8040840141377762455==--

