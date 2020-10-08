Content-Type: multipart/mixed; boundary="===============0889014473528800156=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] station: Make Disconnect() cancel
 ConnectHiddenNetwork()
Date: Thu, 08 Oct 2020 09:12:38 -0500
Message-ID: <a1bd092c-b54d-f39d-baf1-e97d4cedd0dc@gmail.com>
In-Reply-To: <20201008084911.1046485-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0889014473528800156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/8/20 3:49 AM, Andrew Zaborowski wrote:
> ConnectHiddenNetwork can be seen a triggering this sequence:
> 1. the active scan,
> 2. the optional agent request,
> 3. the Authentication/Association/4-Way Handshake/netconfig,
> 4. connected state
> =

> Currently Disconnect() interrupts 3 and 4, allow it to also interrupt
> state 1.  It's difficult to tell whether we're in state 2 from within
> station.c.

Makes sense.  If you want to take care of 2, then we'd need to invoke =

station_network_foreach and abort the agent requests on each network.

> ---
>   src/station.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> =


Applied, thanks.

Regards,
-Denis
--===============0889014473528800156==--

