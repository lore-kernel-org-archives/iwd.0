Content-Type: multipart/mixed; boundary="===============3782466155840413012=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 12/12] dpp: fix dpp_offchannel_start corner cases
Date: Thu, 20 Jan 2022 14:20:22 -0600
Message-ID: <33106f30-3066-e970-73a2-981276c50c6c@gmail.com>
In-Reply-To: 20220118212512.2017977-12-prestwoj@gmail.com

--===============3782466155840413012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/18/22 15:25, James Prestwood wrote:
> The purpose of this was to have a single utility to both cancel an
> existing offchannel operation (if one exists) and start a new one.
> =

> The problem was the previous offchannel operation was being canceled
> first which opened up the radio work queue to other items. This is
> not desireable as, for example, a scan would end up breaking the
> DPP protocol most likely.
> =

> Starting the new offchannel then canceling is the correct order of
> operations but to do this required saving the new ID, canceling, then
> setting offchannel_id to the new ID so dpp_presence_timeout wouldn't
> overwrite the new ID to zero.
> =

> This also removes an explicit call to offchannel_cancel which is
> already done by dpp_offchannel_start.
> ---
>   src/dpp.c | 23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============3782466155840413012==--

