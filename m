Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BDCD531
	for <iwd@lists.linux.dev>; Mon,  7 Nov 2022 15:54:07 +0000 (UTC)
Received: by mail-yb1-f182.google.com with SMTP id z192so14173371yba.0
        for <iwd@lists.linux.dev>; Mon, 07 Nov 2022 07:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M94Lai8qv2f4db2Lnv+fALgnUkiI4qk8vZPRTYMQmEM=;
        b=d1jllBfc7/Gp0ZSnA2vUUccfklX5LeRWfDvTHMy4t9EyoPzRlMLRsTBhjzS93MxIWx
         wW8BQSvD0gw1HLgk+bt6b9TGrLmv9wbo+7nkjJpZtCsJxbKWsQRnNqBuEpLzsQpaqklb
         6I3gfAxY7ZfzQ5HLdDy8/0DBaee8WZ4kQmE6qMHdal88ipr/5pxghYKufeU/RvOFTV2i
         UhZsprd36RHGNJgFCN46oGOloTadBp/vaY73dTB7QWTGNwdNeK08sWEgILmkd9LtYJ/Z
         uBu+d0Wyf7WvHwf0wkIeqUU6z4lJ+MCWUuhi+OcWdDPNogfjzAj/rgfCskupWWZkZIqe
         kdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M94Lai8qv2f4db2Lnv+fALgnUkiI4qk8vZPRTYMQmEM=;
        b=PBmT9P592fjACqqrCGArA1/CGcA7QU0nNVPPkspFimSl40J+xSa0WPiNtZR29NUoLk
         EZa2ytqbXmLFnjza7xJAILXFjO9FUcVhcsV3YU4tSbGErS1K9bjdOQXz85Y2PBQ/RSL8
         bayD+z7XLNbRUT6PQD8XUsPatn1XzPIP/a0KkCXyllV/x7YmYm/jOl5tUUkC+KTa1DDO
         g5cULqleCx1zDcpGu2g89qzKhD6kmfJTMn/Ell4dSyTm+JWEeSxWOJueMVHZPapAb78a
         5ZM8Yg8zYNd3ZzR3x7ElfeKPbmpjnvt7YNX0QlogAoRdOKd0MkqRdjG/cd4V+bq47l7z
         Sxpw==
X-Gm-Message-State: ACrzQf3GYCRKQkTXRuOfKBUVMIZ92LZxBjZAR6WNYDL8YJtJSMoAeDxJ
	F0iqSm24bl6nRcJndk3TZeozMbpZtwAKcstr5Wk=
X-Google-Smtp-Source: AMsMyM4z7dFrKgP/AuzRLdH9KOIjXbsfabGGMtAQMeNadtZ/IjdDStYQ+Q0KHVOGVNNnTzYZU4IX9qvsEmyp/zf4bsQ=
X-Received: by 2002:a25:ef43:0:b0:6cb:cc03:c47 with SMTP id
 w3-20020a25ef43000000b006cbcc030c47mr50202726ybm.372.1667836446769; Mon, 07
 Nov 2022 07:54:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACvgo52+1i7iZ-vzqf1RUpZvMa3-EgaDoid=Y9dch4=d_dq-5Q@mail.gmail.com>
 <772f09aa-fe9e-708e-2ec2-a89f8784d391@gmail.com> <CACvgo50aJHxkC-3E7OHDfjkyH5Rrp+Za+F-ATTCs8w-oX=dhcA@mail.gmail.com>
 <afb76858-3db4-11c9-5d6b-d3cf6d451052@gmail.com>
In-Reply-To: <afb76858-3db4-11c9-5d6b-d3cf6d451052@gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Mon, 7 Nov 2022 15:53:55 +0000
Message-ID: <CACvgo53gsrbynh0e-YXL9nV+HJF=xiRuR2Cj38pYCeApbRRm4w@mail.gmail.com>
Subject: Re: GCMP and other unknown ciphers
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Oct 2022 at 16:32, Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Emil,
>
>
> >>>
> >>> Was my analysis correct - is GCMP supported? Are there any plans on doing so?
> >>
> >> No real plans, patches are always welcome.
> >>
> > Do you have a rough estimate of how much work that might be -  are we
> > talking about weeks or months? How does one get access to the 802.11
> > spec these days?
> >
>
> There is a patchset on the mailing list that implements all ciphers listed in
> 802.11, including GCMP.  Only tested in a synthetic environment since none of my
> commercial APs seem to support anything besides TKIP/CCMP.
>
I've tested it against a Netgear Nighthawk X10 with the following combinations:

WPA2 Personal (without SHA256)
 - CCMP-128 (AES) + GCMP
 - CCMP-256 only
 - GCMP-256 only

All of the above are working like a charm. I haven't tried any
Enterprise combinations due to some unrelated hiccups on my test rig.

Huge thanks for the amazing help
Emil
