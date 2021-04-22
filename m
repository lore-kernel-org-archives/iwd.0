Content-Type: multipart/mixed; boundary="===============7029166667456463017=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] test-runner: fix process cleanup loop
Date: Thu, 22 Apr 2021 13:27:06 -0500
Message-ID: <b038fb48-b94b-7527-0a45-9c9bd2916950@gmail.com>
In-Reply-To: <20210422173746.2324850-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7029166667456463017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/22/21 12:37 PM, James Prestwood wrote:
> The processes in the list ultimately get removed for each
> kill() call. This causes strange behavior since the list is
> being iterated and each iteration is removing items. Instead
> iterate over a new temporary list so the actual process list
> can be cleaned up.
> ---
>   tools/test-runner | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


All applied, thanks.

Regards,
-Denis

--===============7029166667456463017==--

