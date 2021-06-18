Content-Type: multipart/mixed; boundary="===============8160970772257564740=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] station: Stop periodic scan when netdev connected
Date: Fri, 18 Jun 2021 12:21:16 -0500
Message-ID: <fc43e0e1-eb99-97d1-e528-6955c72671a3@gmail.com>
In-Reply-To: <CAOq732+9jc8Mj4Gi+xrgJaVt4BHLx-LEwU9JcaDKg=efL6s0LQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8160970772257564740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 6/18/21 11:16 AM, Andrew Zaborowski wrote:
> On Fri, 18 Jun 2021 at 17:05, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 6/18/21 2:33 AM, Andrew Zaborowski wrote:
>>> For consistency call periodic_scan_stop() right after netdev signals
>>> connected even if station stays in the CONNECTING state because it's
>>> waiting for netconfig to finish.
>>
>> Hmm, why is this needed?  We should be calling periodic_scan_stop as soo=
n as we
>> transition to CONNECTING/CONNECTING_AUTO state.
> =

> That's another option but I think the logic until now was that if the
> connection failed we'd just return to periodic scanning without ever
> stopping and restarting it.  During the netdev CMD_CONNECT it would be

I don't think so.  See commit c3e160880f32f and commit da485179a6e92 prior =
to =

that.  It looks like we have stopped periodic scan when entering CONNECTING =

state for quite some time.

> inhibited by the kernel or by the radio work.  We only needed to
> explicitly stop the scanning when CMD_CONNECT succeeded, so that's
> what I was trying to restore in this patch, otherwise if we were
> unlucky we might have been scanning during the netconfig.

Fair enough, but it doesn't look like your patch does that since we stop th=
e =

periodic scan when we reach CONNECTING state today.

Regards,
-Denis
--===============8160970772257564740==--

