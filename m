Content-Type: multipart/mixed; boundary="===============2253912549105029871=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] ap: handle NEW_STATION for fullmac cards
Date: Thu, 28 Jan 2021 13:28:42 -0600
Message-ID: <75afcdf4-c44e-7d17-03f1-376f78a43dea@gmail.com>
In-Reply-To: <20210128183352.1004552-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2253912549105029871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/28/21 12:33 PM, James Prestwood wrote:
> Since fullmac cards handle auth/assoc in firmware IWD must
> react differently while in AP mode just as it does in station.
> For fullmac cards a NEW_STATION event is emitted post association
> and from here the 4-way handshake can begin. In this NEW_STATION
> handler a new sta_state is created and the needed members are
> set in order to inject us back into the normal code execution
> for softmac post association (i.e. creating group keys and
> starting the 4-way handshake). From here everything works the
> same as softmac.
> ---
>   src/ap.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 111 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============2253912549105029871==--

