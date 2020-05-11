Content-Type: multipart/mixed; boundary="===============3331620485801733072=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/2] netdev: unify ft/auth_proto authenticate builders
Date: Mon, 11 May 2020 18:47:06 +0000
Message-ID: <8fe57ce5-ad0b-a8cb-0424-0d92a8c7e934@gmail.com>
In-Reply-To: <20200507215059.15987-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3331620485801733072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 5/7/20 4:50 PM, James Prestwood wrote:
> build_cmd_ft_authenticate and build_cmd_authenticate were virtually
> identical. These have been unified into a single builder.
> =

> We were also incorrectly including ATTR_IE to every authenticate
> command, which violates the spec for certain protocols, This was
> removed and any auth protocols will now add any IEs that they require.
> ---
>   src/netdev.c | 46 ++++++++--------------------------------------
>   1 file changed, 8 insertions(+), 38 deletions(-)
> =


Both applied, thanks.

Regards,
-Denis
--===============3331620485801733072==--

