Content-Type: multipart/mixed; boundary="===============3456095913136445369=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 1/2] netdev: add check for running work item in
 netdev_disconnect
Date: Mon, 05 Apr 2021 17:24:21 -0500
Message-ID: <ef1f308e-3bb9-c281-9a45-04b117730829@gmail.com>
In-Reply-To: <20210405221836.1049804-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3456095913136445369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/5/21 5:18 PM, James Prestwood wrote:
> The send_disconnect flag was being improperly set based only
> on connect_cmd_id being zero. This does not take into account
> the case of CMD_CONNECT having finished but not EAPoL. In this
> case we do need to send a disconnect.
> ---
>   src/netdev.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> =


both applied, thanks.

Regards,
-Denis

--===============3456095913136445369==--

