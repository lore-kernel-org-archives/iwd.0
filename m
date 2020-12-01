Content-Type: multipart/mixed; boundary="===============3619183534623072393=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] network: clear info of removed known network before
 disconnect
Date: Tue, 01 Dec 2020 10:00:30 -0600
Message-ID: <7f894f64-9b07-f60c-dc91-97b0ff67ca02@gmail.com>
In-Reply-To: <20201127160444.681629-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3619183534623072393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

On 11/27/20 10:04 AM, Alvin =C5=A0ipraga wrote:
> Make sure to erase the network_info of a known network that has been
> removed before disconnecting any stations connected to it. This fixes
> the following warning observed when forgetting a connected network:
> =

>    WARNING: ../git/src/network.c:network_rank_update() condition n < 0 fa=
iled
> =

> This also fixes a bug where such a forgotten network would incorrectly
> appear as the first element in the response to GetOrderedNetworks().  By
> clearing the network_info, network_rank_update() properly negates the
> rank of the now-unknown network.
> ---
>   src/network.c | 28 ++++++++++------------------
>   1 file changed, 10 insertions(+), 18 deletions(-)
> =


Nice catch!  Applied, thanks.

Regards,
-Denis
--===============3619183534623072393==--

