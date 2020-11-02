Content-Type: multipart/mixed; boundary="===============0277203628981655019=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] frame-xchg: fix invalid read
Date: Mon, 02 Nov 2020 11:39:27 -0600
Message-ID: <3ddc4b59-ea98-85bf-2eb4-0eddcf8d3730@gmail.com>
In-Reply-To: <20201030163559.2446740-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0277203628981655019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/30/20 11:35 AM, James Prestwood wrote:
> This seems to happen occationally with testAP (potentially others).
> The invalid read appears to happen when the frame_xchg_tx_cb detects
> an early status and no ACK. In this particular case there is no
> retry interval so we reach the retry limit and 'done' the frame.
> This frees the 'fx' data all before the destroy callback can get
> called. Once we finally return and the destroy callback is called
> 'fx' is freed and we see the invalid write.
> =


Applied, thanks.

Regards,
-Denis

--===============0277203628981655019==--

