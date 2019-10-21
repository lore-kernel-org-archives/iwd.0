Content-Type: multipart/mixed; boundary="===============6699010935212699199=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] client: Init variable before usage
Date: Mon, 21 Oct 2019 11:03:31 -0500
Message-ID: <2b1aa195-f70e-89f0-4d96-a97fe0fa8703@gmail.com>
In-Reply-To: <20191018215803.19398-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6699010935212699199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 10/18/19 4:58 PM, Tim Kourt wrote:
> Uninitialized 'password' variable used to cause an error when --password
> option wasn't avaiable
> ---
>   client/agent.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============6699010935212699199==--

