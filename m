Content-Type: multipart/mixed; boundary="===============4711164471171093230=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd stuck 'connecting', out-of-order wiphy work queue?
Date: Thu, 28 Apr 2022 11:41:32 -0500
Message-ID: <9c8e4116-caaf-932c-c8f7-22d9c64de9c8@gmail.com>
In-Reply-To: 20220428144446.uaagkaurxypzjs5k@bang-olufsen.dk

--===============4711164471171093230==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

> However, the bottom line seems to be that the out-of-order work causes us=
 not to
> immediately queue the next work item in wiphy_radio_work_done():

Correct.  The logic is a hold-over from when we didn't use priorities.  So =
the =

assumption is that what is on the top of the queue is the 'running' task.  =
This =

is no longer the case.  However, this logic breaks down only in very specif=
ic =

conditions which you uncovered.

<snip>

> Specifically, the id that wiphy_radio_work_done() gets called with (4) do=
esn't
> match the id of the work on top of the queue (5). So next stays false and=
 we
> don't call wiphy_radio_work_next().
> =

> Can anybody explain what the reason for this 'next' variable is? It seems=
 like
> we would always want to start the next work, no?

The reason for it is that we might remove work items that are not running. =
 We =

can only run a single work item at a time, so this is distinguishing betwee=
n a =

'running work done' and 'non-running work done'.  In the latter case, we =

shouldn't start any new work.

> =

> Not that this is a fix to the out-of-order work (start 4, done 5, see abo=
ve),
> but I could work around iwd getting stuck by refactoring the above functi=
on
> according to the attached patch. Basically I just removed the logic of th=
is
> 'next' variable and unconditionally call wiphy_radio_work_next().
> =


I think this is close.  But you need to account for the above.  We can do i=
t in =

one of two ways:

1. when a work item is started, it is artificially assigned INT_MIN priorit=
y. =

So you can use that as an indicator whether the work item being finished is =

running or not.

2. Introduce a specific bool for this purpose.

We also need to update the implementation of wiphy_radio_work_is_running() =
since =

that is also wrong.

Regards,
-Denis
--===============4711164471171093230==--

