Content-Type: multipart/mixed; boundary="===============1822763317216955225=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/2] auto-t: update roaming tests with
 wait_for_object_change
Date: Sat, 06 Feb 2021 00:50:47 +0100
Message-ID: <CAOq732Je57sQrXz-frVXuLrZFT6EvyzDWgVjYA4N5k+RYyW=iw@mail.gmail.com>
In-Reply-To: <20210205190637.325992-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1822763317216955225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On Fri, 5 Feb 2021 at 20:06, James Prestwood <prestwoj@gmail.com> wrote:
> Every single roaming test had one of two problems with watching the
> state change between roaming --> connected. Either the test used
> wait_for_object_condition to wait for 'connected' which could allow
> other states in between. Or it simply used an assert. The assert
> wouldn't allow other state changes, but at the cost of potentially
> failing due to IWD not having made it to the 'connected' state yet.

Can you give an example of a sequence of states?  I can't see a
scenario where there would be a difference between the state before
ce5e1e1933dbb11c503702ca0ee7a3d0f142ff4b and after this patch.

Best regards
--===============1822763317216955225==--

