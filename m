Content-Type: multipart/mixed; boundary="===============7108958329251298647=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] auto-t: move AuthCenter to Setup/Tear down
Date: Wed, 21 Apr 2021 13:55:57 -0500
Message-ID: <61082cf0-6682-aec8-fd7b-9710496d0e2e@gmail.com>
In-Reply-To: <20210421184228.2272285-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7108958329251298647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/21/21 1:42 PM, James Prestwood wrote:
> By moving the AuthCenter initializer to SetUpClass we can now
> call stop() in TearDownClass which handles any exception the
> test might throw.
> ---
>   autotests/testEAP-AKA-ofono/connection_test.py     | 14 +++++---------
>   .../testEAP-AKA-prime-ofono/connection_test.py     | 14 ++++----------
>   autotests/testEAP-SIM-ofono/connection_test.py     | 14 +++++---------
>   3 files changed, 14 insertions(+), 28 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============7108958329251298647==--

