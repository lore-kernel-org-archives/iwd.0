Content-Type: multipart/mixed; boundary="===============8267304407184334211=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] auto-t: separate PEAP + SIM test
Date: Tue, 17 Aug 2021 17:02:56 -0500
Message-ID: <e6f73884-c75d-b7f5-0fb3-2e777cc9adb8@gmail.com>
In-Reply-To: <20210817215002.212694-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8267304407184334211==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/17/21 4:50 PM, James Prestwood wrote:
> Remove EAP-SIM from the generic PEAP test case since skipping
> (if ofono is not on system) would skip the entire test rather
> than just the EAP-SIM portion.
> ---
>   autotests/testEAP/connection_test.py | 29 ++++++++++++++++++++++++----
>   1 file changed, 25 insertions(+), 4 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============8267304407184334211==--

