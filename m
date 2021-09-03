Content-Type: multipart/mixed; boundary="===============2453798272043982893=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] autotests: Extend a testP2P timeout
Date: Fri, 03 Sep 2021 14:45:52 -0500
Message-ID: <5eb59028-9b60-8350-16db-3c695a6bfcd4@gmail.com>
In-Reply-To: <20210903190643.252321-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2453798272043982893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/3/21 2:06 PM, Andrew Zaborowski wrote:
> With various versions of wpa_supplicant tested, after an IWD GO tears
> the group down, the wpa_supplicant P2P client will not immediately
> signal that the group has disappeared but will at least wait for the
> lost beacon signal, wait some more and try reconnecting and all that
> takes it 10s or a little longer.  Possibly sending Deauthenticate frames
> to clients first would improve this.
> ---
>   autotests/testP2P/connection_test.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Both applied, thanks.

Regards,
-Denis

--===============2453798272043982893==--

