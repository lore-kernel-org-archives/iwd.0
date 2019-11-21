Content-Type: multipart/mixed; boundary="===============4981399527079506203=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 4/6] scan: parse the scan start time
Date: Wed, 20 Nov 2019 20:21:53 -0600
Message-ID: <09b0dbc2-5989-3d64-456a-7c9c86401f74@gmail.com>
In-Reply-To: <20191120173146.21452-4-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4981399527079506203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/20/19 11:31 AM, James Prestwood wrote:
> The kernel sends NL80211_ATTR_SCAN_START_TIME_TSF with CMD_TRIGGER and
> RRM requires this value for beacon measurement reports. Since this
> value is sent with CMD_TRIGGER we have to store it in the scan_context
> and set it into the scan_bss when the scan finishes.

That seems rather expensive?  To store an 8 byte value in all the bsses =

that really belongs in the trigger callback?  Perhaps we should just =

pass it in as an additional argument.

Or since we have the scan_request id, perhaps it should be obtainable =

using that?  E.g. something like:

uint64_t scan_get_triggered_time(uint32_t id);

> ---
>   src/scan.c | 13 +++++++++++++
>   src/scan.h |  1 +
>   2 files changed, 14 insertions(+)
> =


Regards,
-Denis
--===============4981399527079506203==--

