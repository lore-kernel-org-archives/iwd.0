Content-Type: multipart/mixed; boundary="===============8128948317323217764=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] client: remove warning on mkdir return
Date: Tue, 09 Feb 2021 14:50:18 -0600
Message-ID: <28cc4431-2768-8b53-db44-686720489bed@gmail.com>
In-Reply-To: <20210209203713.756142-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8128948317323217764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/9/21 2:37 PM, James Prestwood wrote:
> This fixes up a previous commit which breaks iwctl. The
> check was added to satisfy static analysis but it ended
> up preventing iwctl from starting. In this case mkdir
> can fail (e.g. if the directory already exists) and only
> if it fails should the history be read. Otherwise a
> successful mkdir return indicates the history folder is
> new and there is no reason to try reading it.
> ---
>   client/display.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============8128948317323217764==--

