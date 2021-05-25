Content-Type: multipart/mixed; boundary="===============8349295775289894605=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: Re: [PATCH] netdev: station: support channel switch events
Date: Tue, 25 May 2021 15:24:17 +0000
Message-ID: <4da58dad-46ac-e56f-7150-b65f077710b3@bang-olufsen.dk>
In-Reply-To: <20210525152020.3304052-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8349295775289894605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 5/25/21 5:20 PM, Alvin =C5=A0ipraga wrote:
> If the connected BSS announces that it is switching operating channel,
> the kernel may emit the NL80211_CMD_CH_SWTICH_NOTIFY event when the
> switch is complete. Handle this event in netdev in a way similar to the
> NL80211_CMD_ROAM event by getting the new BSS info and passing it to
> station. station will then update its current_bss member.
> =

> This enables iwd to keep track of the current operating frequency after
> a channel switch. Previously iwd would ignore this event and the output
> of 'iwctl station wlan0 show' would show the old frequency.
> ---
>   src/netdev.c  | 71 +++++++++++++++++++++++++++++++++++++++++++++++++--
>   src/netdev.h  |  1 +
>   src/station.c | 21 +++++++++++++++
>   3 files changed, 91 insertions(+), 2 deletions(-)

<snip>

I have an autotest prepared for this change, but for some reason the =

hwsim driver only emits the CH_SWITCH_NOTIFY event on the AP interface, =

making the scenario un-testable. Therefore I am sending just the =

functional change right now.

I will try to dig a little deeper to see why I am not getting this event =

on the station interface, but any tips are welcome.

Thanks!

Kind regards,
Alvin
--===============8349295775289894605==--

