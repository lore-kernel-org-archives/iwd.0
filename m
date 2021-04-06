Content-Type: multipart/mixed; boundary="===============1263899435704532231=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] unit: remove timeout tests from test-sae
Date: Tue, 06 Apr 2021 15:03:54 -0500
Message-ID: <6dee509e-871b-0ccd-958d-09eb1a80a3b7@gmail.com>
In-Reply-To: <20210406182946.1087095-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1263899435704532231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/6/21 1:29 PM, James Prestwood wrote:
> The timeout functionality was removed from the core SAE
> implementation as it causes issues with kernel behavior.
> Because of this the timeout tests are no longer valid,
> nor is a few asserts in the end-to-end test.
> ---
>   unit/test-sae.c | 66 +------------------------------------------------
>   1 file changed, 1 insertion(+), 65 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============1263899435704532231==--

