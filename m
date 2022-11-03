Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2CB63C7
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 19:01:33 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id m6so2531718pfb.0
        for <iwd@lists.linux.dev>; Thu, 03 Nov 2022 12:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1bN9YBv1P99FCBir1eL2eK5VO1E9NhJ119sf9RLp7dw=;
        b=kngB2qd3hifHO55clnO/lRiVzR1MFPlwik8qQHPAX9n1N2edmaFG6TMjmb/ClK91JY
         V7/lBoDDEhwd6zCz/VbVEia/4Geju/7mhCaXzgNhganloGkQPClhFtE/Z+fweQPR6RUz
         fYa5Gd53WHXI8y6cs7OfWDc8Il97rIFdbFSWY7ZTxx8vXOVT70UMVdgvKEHf7V2BRNRX
         vvd887NkRK5zIwfuGWneoRSQchGNgurKZDkdLiQoOLrhulRNOTmb+ax2uhlTwCZAQvaA
         jFICjyzbLGOVYyOaQ8PXyD9aOvlA5WK4YkoBvcFx3u7bWVaU44whIgaEjUeSJoU/xAt6
         pQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1bN9YBv1P99FCBir1eL2eK5VO1E9NhJ119sf9RLp7dw=;
        b=M3GQu/4/yqAKRPOyPs/fL5neWndJAOaEpDU9aM5Wxctp94f4GClM/M9eml6eRZZwMx
         ZDMe3+7ertnkv5+PPlT0YnIpXw9o921GtzWarP28atNZmx7nXPRDZIof5QCC7EEvOPSF
         6nfIF1RBsrJhXkinlUTJvPW9ehc7vKrEQYnA4IRadqm/U5dsT7pqhjXCLQRH4l7sC0Tm
         wJCopmWEdbZ8T6spCtHEor+8J3WBTBKeU9/M4EQW3DgLGgab1d5z0joMbflhI1CzKUEk
         b9bsNJqKD4QINZPy7LJdFZ4GMiDFTS2j4CRH2jpIOX7gtcATfDjOalKCAMDTYCCqEjjb
         i31A==
X-Gm-Message-State: ACrzQf09BQqJD/pBXH0fU6eIAEkkVt6QVwY/rRlsCf4xPl8VoV9GEPLm
	at7dTnO6yPnMahD3CNdUgfIapArwPA8=
X-Google-Smtp-Source: AMsMyM7loP+JN1gPeQHr2zKkd5311BcrM0h5B5cY2CY4j4iLs+0jSZTaUo9rJ3A6fPN6/zTVdU7z+w==
X-Received: by 2002:a63:b4d:0:b0:454:d8b4:285 with SMTP id a13-20020a630b4d000000b00454d8b40285mr27548870pgl.410.1667502092586;
        Thu, 03 Nov 2022 12:01:32 -0700 (PDT)
Received: from [192.168.254.82] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id i18-20020aa796f2000000b0053e468a78a8sm1072658pfq.158.2022.11.03.12.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:01:32 -0700 (PDT)
Message-ID: <239fb4e91036371a8e1f9dfb93556cc3d97c902c.camel@gmail.com>
Subject: Re: [PATCH 1/4] doc: document AP properties
 PairwiseCiphers/GroupCipher
From: James Prestwood <prestwoj@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: iwd@lists.linux.dev
Date: Thu, 03 Nov 2022 12:01:31 -0700
In-Reply-To: <C39B9D23-000E-44A9-AFFC-3805CECAE5C9@holtmann.org>
References: <20221103173057.381232-1-prestwoj@gmail.com>
	 <C39B9D23-000E-44A9-AFFC-3805CECAE5C9@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2022-11-03 at 19:17 +0100, Marcel Holtmann wrote:
> Hi James,
> 
> > ---
> > doc/access-point-api.txt | 13 +++++++++++++
> > 1 file changed, 13 insertions(+)
> > 
> > diff --git a/doc/access-point-api.txt b/doc/access-point-api.txt
> > index 63e61d49..28e6437d 100644
> > --- a/doc/access-point-api.txt
> > +++ b/doc/access-point-api.txt
> > @@ -71,3 +71,16 @@ Properties   boolean Started [readonly]
> >                 uint32 Frequency [readonly, optional]
> > 
> >                         The frequency that the Access Point is
> > operating on.
> > +
> > +               string PairwiseCiphers [readonly, optional]
> > +
> > +                       Comma separated list of pairwise ciphers
> > the access
> > +                       point supports. The same format as setting
> > a list of
> > +                       ciphers for an AP  profile, i.e. TKIP,
> > CCMP-128,
> > +                       GCMP-128, CCMP-256, GCMP-256 etc.
> 
> why not array{string} since that makes it a cleaner from an API point
> of view.

We could do this yes. The implemenation has already been merged but we
could change this to an array easy enough.

> 
> Regards
> 
> Marcel
> 


