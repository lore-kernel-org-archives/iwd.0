Content-Type: multipart/mixed; boundary="===============4559197575827935163=="
MIME-Version: 1.0
From: Will Dietz <w@wdtz.org>
Subject: [PATCH] crypto: fix copy size causing overruns/crashing
Date: Thu, 03 Oct 2019 11:35:16 -0500
Message-ID: <20191003113516.GC8802@dtznix>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4559197575827935163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

num_ad is already accounted for in `sizeof(iov)`
as iov has size `sizeof(struct iovec) * (num_ad+1)`.
---
 src/crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/crypto.c b/src/crypto.c
index 632117d..62edd44 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -311,7 +311,7 @@ bool aes_siv_encrypt(const uint8_t *key, size_t key_len=
, const uint8_t *in,
        struct iovec iov[num_ad + 1];
        uint8_t v[16];
 =

-       memcpy(iov, ad, sizeof(iov) * num_ad);
+       memcpy(iov, ad, sizeof(struct iovec) * num_ad);
        iov[num_ad].iov_base =3D (void *)in;
        iov[num_ad].iov_len =3D in_len;
        num_ad++;
@@ -368,7 +368,7 @@ bool aes_siv_decrypt(const uint8_t *key, size_t key_len=
, const uint8_t *in,
        if (in_len < 16)
                return false;
 =

-       memcpy(iov, ad, sizeof(iov) * num_ad);
+       memcpy(iov, ad, sizeof(struct iovec) * num_ad);
        iov[num_ad].iov_base =3D (void *)out;
        iov[num_ad].iov_len =3D in_len - 16;
        num_ad++;
-- =

2.23.GIT

--===============4559197575827935163==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSXpCQUFCQ2dBZEZpRUVHUDJWQTNxVlpm
Y0hzWG9yNjdEcVFTU0FuUUlGQWwyV0kwUUFDZ2tRNjdEcVFTU0EKblFKeVF3LytPRm1iZ3JianpB
TWJaa3d3N0U3b0JMU3F3TTlobzdvd3Vpak5KY0Y3N3lDNDFFQzZRak5RYjllUQpFaEp0aVVSeEtz
SXJxQkN3bVpiNG15Vmppd3Vld3VON2Q1Q0FDNy9VcHhjVlJyMWM0RTMwZkNyUmEvcXMxZXZkCktS
QWZ0ZG95T2ZXUkhmZW03OStqajRWTmNUUnc3UWZrNzRTZVBISUZVclBzckw2R3MxSWNoZHoxU0hU
Y2ljZDIKbUdZWEI1UDVLMEMzUCs1SzRyNXAvY09NMnNGbFJIM3BWU3B5U3Y2ckhwbWU1azBXdHdo
UlJHalM2eVY0Mlc0MgpJQkp5ckpaYUhERW5WUG81MVd3VzZGRGtMTTBmN2dTaXgzR2ZXdW1TUXVt
eUhnaExhQk9uOHRzS0lqWUpOUTlGCmluWVMvSEozNWxxdjNKTTR6SFFKNGhCT3BwbEZqaXdnSlRN
aGdFVUhnTXZmWHR1M1F0dC96bml1dDU1N0FMRnQKS25DYTNjT2FmamxwUnp1SnUvK0Y2Y0M0TkFC
Zm1vZDE1VTB4bitVdkJ0cUhCUTNVNnhuSW01bWJJQXR4RjRheApIcmZSS0MzSXA3dmdOT0d1R01p
TW9BNnExKzR2eGt3ZXkyclVqeWZscTZHMmxhVUpUdENOTXh5clV6Z2JKTU1zClI1MnRyN2RoQlVt
UlI0eVdoOVptQzNTMmVtQ0lYbWdHMFNpWkhRVmtGczF2ZnBxbko2eXJDM0xDTVhmU0IrcVoKd0Nq
SlFrZFg3Mzg2V1U3MUxXTU9pSGlRY2ZqY0w5YUFQMzZydXJRc3Rrczd3S1plN1lqQjBVSklSNFdC
MDkxZwpDcVJXOXNDZ1AxQWRoeUhHa2hpVklBQmlySVZXRXU4SG9TSFo0U1MwLzJoRWZQUkVnYnM9
Cj1hYU56Ci0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============4559197575827935163==--

