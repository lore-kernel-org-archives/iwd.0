Content-Type: multipart/mixed; boundary="===============1094737346354015839=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v5 1/4] scan: parse the scan start time
Date: Thu, 21 Nov 2019 13:59:18 -0600
Message-ID: <bcdbb6de-3d05-6eb1-b3b6-2f1e5493e2b1@gmail.com>
In-Reply-To: <20191121200901.25826-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1094737346354015839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/21/19 2:08 PM, James Prestwood wrote:
> The kernel sends NL80211_ATTR_SCAN_START_TIME_TSF with CMD_TRIGGER and
> RRM requires this value for beacon measurement reports.
> =

> The start time is parsed during CMD_TRIGGER and set into the scan request.
> A getter was added to obtain this time value for an already triggered
> scan.
> =

> After making the change, the SCAN_ABORTED case was cleaned up a bit to
> remove the local scan_request usage in favor of the one used for all the
> other cases.
> ---
>   src/scan.c | 41 ++++++++++++++++++++++++++++++++++-------
>   src/scan.h |  2 ++
>   2 files changed, 36 insertions(+), 7 deletions(-)
> =


I went ahead and took the first 3 in this series.  The last one has some =

missing L_CPU_TO_LE* calls.

Regards,
-Denis

--===============1094737346354015839==--

