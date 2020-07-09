Content-Type: multipart/mixed; boundary="===============5703248498006268102=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 1/6] wiphy: introduce new radio management APIs
Date: Thu, 09 Jul 2020 10:46:15 -0500
Message-ID: <63363d6a-1f22-a92d-0f83-b24d21f304c0@gmail.com>
In-Reply-To: <20200709000437.32719-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5703248498006268102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 7/8/20 7:04 PM, James Prestwood wrote:
> These APIs will handle fairness and order in any operations which
> radios can only do sequentially (offchannel, scanning, connection etc.).
> =

> Both scan and frame-xchg are complex modules (especially scanning)
> which is why the radio management APIs were implemented generic enough
> where the changes to both modules will be minimal. Any module that
> requires this kind of work can push a work item into the radio
> management work queue (wiphy_radio_work_insert) and when the work
> is ready to be started radio management will call back into the module.
> Once the work is completed (and this may be some time later e.g. in
> scan results or a frame watch) the module can signal back that the
> work is finished (wiphy_radio_work_done). Wiphy will then pop the
> queue and continue with the next work item.
> =

> A concept of priority was added in order to allow important offchannel
> operations (e.g. ANQP) to take priority over other work items. The
> priority is an integer, where lower values are of a higher priority.
> The concept of priority cleanly solves a lot of the complexity that
> was added in order to support ANQP queries (suspending scanning and
> waiting for ANQP to finish before connecting).
> =

> Instead ANQP queries can be queued at a higher priority than scanning
> which removes the need for suspending scans. In addition we can treat
> connections as radio management work and insert them at a lower
> priority than ANQP, but higher than scanning. This forces the
> connection to wait for ANQP without having to track any state.
> ---
>   src/wiphy.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/wiphy.h |  22 +++++++++++
>   2 files changed, 134 insertions(+)
> =

> v2:
>   - Better optimized wiphy_radio_work_done to not iterate the queue
>     more than it needs to.
> =


Patches 1-3, 5 applied now, thanks.

Regards,
-Denis

--===============5703248498006268102==--

