Content-Type: multipart/mixed; boundary="===============4745288497211937369=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 12/17] ap: Accept P2P wildcard SSIDs in probe requests
Date: Wed, 09 Sep 2020 14:53:12 -0500
Message-ID: <f02ffb90-4f37-c370-4f62-c17b7472f3df@gmail.com>
In-Reply-To: <20200908234933.301439-12-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4745288497211937369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/8/20 6:49 PM, Andrew Zaborowski wrote:
> Add the special case "DIRECT-" SSID, called the P2P Wildcard SSID, in
> ap_probe_req_cb so as not to reject those Probe Requests on the basis of
> ssid mismatch.  I'd have preferred to keep all the P2P-specific bits in
> p2p.c but in this case there's little point in adding a generic
> config setting for SSID-matching quirks.
> ---
>   src/ap.c | 3 +++
>   1 file changed, 3 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============4745288497211937369==--

