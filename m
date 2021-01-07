Content-Type: multipart/mixed; boundary="===============8947535877829010630=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] crypto: Update l_pkcs5_pbkdf2 call after rename
Date: Thu, 07 Jan 2021 14:08:58 -0600
Message-ID: <ea7f5c93-ee9d-f47e-43e2-660711a3f138@gmail.com>
In-Reply-To: <20201223232215.1078347-2-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8947535877829010630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 12/23/20 5:22 PM, Andrew Zaborowski wrote:
> ---
> This fixes up crypto_psk_from_passphrase after the rename in ell and
> should only be applied if/after the commit
> "pkcs5: Rename to cert-crypto" is pushed to ell.
> ---
>   src/crypto.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> =


Applied,  thanks.

I also made some build updates prior to this commit that were needed due to =

pkcs5.c restructuring.  Please sanity check...

Regards,
-Denis

--===============8947535877829010630==--

