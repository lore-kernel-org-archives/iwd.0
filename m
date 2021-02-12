Content-Type: multipart/mixed; boundary="===============2083520359311002361=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] auto-t: fix blacklist test timing issues
Date: Thu, 11 Feb 2021 20:32:53 -0600
Message-ID: <e67a27e1-cc81-7d39-5a0f-318fbe136be7@gmail.com>
In-Reply-To: <20210211231614.910157-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2083520359311002361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/11/21 5:16 PM, James Prestwood wrote:
> This test fails randomly, and it appears to be due to excessive
> scanning. Historically most autotests start a dbus scan right
> away. The problem is that most likely a periodic scan is already
> ongoing, meaning the dbus scan gets queued. If a Connect() call
> comes in (which it always does), the dbus scan gets delayed and will
> trigger once connected, at a time the test is not expecting. This
> can cause problems with any assumed timing as well as offchannel
> frames.
> =

> This patch removes the explicit DBus scanning and instead uses
> scan_if_needed with get_ordered_networks. The 'all_blacklisted_test'
> was also modified to wait for scanning to complete after failing
> to connect to all BSS's. This lets all the networks fully come
> up (after being blocked by hwsim) and appear in scan results.
> ---
>   .../testBSSBlacklist/all_blacklisted_test.py      | 15 ++++++---------
>   autotests/testBSSBlacklist/bad_pass_test.py       | 10 +---------
>   autotests/testBSSBlacklist/connection_test.py     | 10 +---------
>   autotests/testBSSBlacklist/temp_blacklist_test.py | 10 +---------
>   4 files changed, 9 insertions(+), 36 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============2083520359311002361==--

