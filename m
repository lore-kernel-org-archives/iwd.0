Content-Type: multipart/mixed; boundary="===============6695780064333774599=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] module: Fix variable names
Date: Mon, 11 Nov 2019 18:30:48 -0600
Message-ID: <9b322da2-5f13-fc28-3eb2-fcf95b3689b7@gmail.com>
In-Reply-To: <20191111123417.2103-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6695780064333774599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 11/11/19 6:34 AM, Andrew Zaborowski wrote:
> Apparently the intention was for the dependent module's name to appear
> in the variable name resulting from using IWD_MODULE_DEPENDS, so the
> dependencies all have unique names (apparently not critical).
> ---
>   src/module.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Both applied, thanks.

Regards,
-Denis

--===============6695780064333774599==--

