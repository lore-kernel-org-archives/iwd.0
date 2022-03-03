Content-Type: multipart/mixed; boundary="===============4672501449292183979=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2] knownnetworks: use band_freq_to_channel to verify
 known freqs
Date: Thu, 03 Mar 2022 14:41:49 -0600
Message-ID: <40bae1e6-3d5b-9318-8de4-c54dc4a230ec@gmail.com>
In-Reply-To: 20220303200955.3454945-1-prestwoj@gmail.com

--===============4672501449292183979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/3/22 14:09, James Prestwood wrote:
> With the addition of 6GHz '6000' is no longer the maximum frequency
> that could be in .known_network.freq. For more robustness
> band_freq_to_channel is used to validate the frequency.
> ---
>   src/knownnetworks.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============4672501449292183979==--

