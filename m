Content-Type: multipart/mixed; boundary="===============6690133082392463153=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] auto-t: use hwsim_medium=no (testSAE/HiddenNetworks)
Date: Tue, 17 Nov 2020 13:30:46 -0600
Message-ID: <bdd42b70-cb4c-c418-8321-ea40e6318d27@gmail.com>
In-Reply-To: <20201117185007.3536477-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6690133082392463153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/17/20 12:50 PM, James Prestwood wrote:
> Both these tests create many radios which sometimes causes timing
> problems when hwsim is running. Since hwsim is not required for
> these tests we can disable it and increase test reliability.
> ---
>   autotests/testHiddenNetworks/hw.conf | 3 +--
>   autotests/testSAE/hw.conf            | 2 +-
>   2 files changed, 2 insertions(+), 3 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============6690133082392463153==--

