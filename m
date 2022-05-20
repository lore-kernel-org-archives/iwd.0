Content-Type: multipart/mixed; boundary="===============2998117628930239964=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: Re: Unsupported finite cyclic group
Date: Fri, 20 May 2022 17:56:30 +0100
Message-ID: <CACsRnHXwiVWBBx9k--3j4XWkPX=cwhBDQr81w9a98BjAa-E85A@mail.gmail.com>
In-Reply-To: 8d92aea3-241c-85ed-6742-14a61203edc4@gmail.com

--===============2998117628930239964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I'm fairly sure it was doing FT as it is set up for that and I don't
see a 4 way handshake in the log. I do see
`station_fast_transition_cb` being called as well so I guess it was
trying FT?
```
May 19 16:16:11.696848 r2-19105 iwd[462]:
src/station.c:station_fast_transition_cb() 5, result: 2
```
The AP hasn't changed for a while now so I don't think it is directly
that however it could be that the error it is giving is complete
nonsense. A second prior to the "finite cycle group" error it does
also say there was an "Invalid authentication" from the same client so
maybe it is a red herring if it doesn't make sense in the context.

Looking more into the difference between 1.21 and master clients,
oddly I actually see the failure to roam in both (looking for the
station_fast_transition with result 2) however the AP only reports
errors for the clients running master. Odd.

The other two errors which happen after this on master don't happen on
1.21. In that case iwd performs a passive scan (same) and then
connects fine without any "Error sending CMD_ASSOCIATE (-2)" error.
Likewise the neighbor report is fine in 1.21 but not master.

Sorry, I think I'm missing some hidden variable here so I'll see if I
can create a better bug report. I'll set up a capture of iwmon logging
to get more solid data to go on and narrow down what is happening in
what version.

Regards,
Michael
--===============2998117628930239964==--

