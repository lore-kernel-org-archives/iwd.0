Content-Type: multipart/mixed; boundary="===============2012012060632238334=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v6 1/4] netdev: better handle disconnect after FW scan
Date: Fri, 02 Apr 2021 17:26:30 -0500
Message-ID: <84bf4a3d-4f8e-7a84-f0cf-8523c6f97b67@gmail.com>
In-Reply-To: <20210402220617.937790-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2012012060632238334==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/2/21 5:06 PM, James Prestwood wrote:
> This should have been updated along with the connect and roam
> event separation. Since netdev_connect_event is not being
> re-used for CMD_ROAM the comment did not make sense anymore.
> Still, there needs to be a check to ensure we were not disconnected
> while waiting for GET_SCAN to come back.
> ---
>   src/netdev.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============2012012060632238334==--

