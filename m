Content-Type: multipart/mixed; boundary="===============9156070789625345033=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/8] netdev: Track SET_INTERFACE events
Date: Fri, 23 Apr 2021 09:52:24 -0500
Message-ID: <a7173ee7-3deb-29be-4ab2-af3994861c97@gmail.com>
In-Reply-To: <20210420163519.12375-1-denkenz@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9156070789625345033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 4/20/21 11:35 AM, Denis Kenzior wrote:
> And set the interface type based on the event rather than the command
> callback.  This allows us to track interface type changes even if they
> come from outside iwd (which shouldn't happen.)
> ---
>   src/netdev.c | 47 +++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 41 insertions(+), 6 deletions(-)
> =


All applied.
--===============9156070789625345033==--

