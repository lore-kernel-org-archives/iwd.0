Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01D17A
	for <iwd@lists.linux.dev>; Wed, 27 Jul 2022 16:00:29 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id f11-20020a17090a4a8b00b001f2f7e32d03so3398758pjh.0
        for <iwd@lists.linux.dev>; Wed, 27 Jul 2022 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=UGpFgeAbSMnwhiotO+0LMZ8vlkUISc6/JLJNhtj3zQ8=;
        b=MrgGyzHhua2fZCt6ZRn4Sxlw1ZqbKA3XPd147kQkfUm0IX/nBC1ymhN/4pbYSISPz9
         MDjPLEHmsbmfU6RwHWhL5v0OQF/rzC+GVIYK5BslvswgeLwkAwAHCZc5JoH4tT4NdQY8
         fUKXmdYcGmTDqOynoUMCGQVCo5iWm+BmfagyLE5Ni0FTQJCwXHIZ6dgiSpOagHJhFWkf
         DhtfPoBnP7Z24FH2NCffbkTdP18eu2sbxbiVAEFSvcJuv62q+/FPgB6IEBdBOQCh2lsI
         gvGj/ztwOXQ2uTHhVieuBI+VRPqHiys3yxL006RdG3DfttBxbr1YY1fwopmHfy4Mc+92
         9SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=UGpFgeAbSMnwhiotO+0LMZ8vlkUISc6/JLJNhtj3zQ8=;
        b=BpvOtG/0RBvDi3Nl5csmfO5kCQBYBv8hUlD7zj4r3iKy0EYF59kwQK1O/Z1Y52Iswb
         YK+nrkaJCaCRmyWv4TamlDipghBgzLerDHXWSFQakU/+3KG/P9lH5zbKeKJ3uG9e3kKD
         tMgl30tjcIgiU3rOQLx0PAuua7jSsx6DktNSX9PYqnLeRx/kJGWqvwlKsVV6ICN16feF
         BK1tbNAJV5QqgcsPHWfPuNu2PVqClVMgC1Hz+opUJD57KnxSxPJSeYYNTf6TVtO+bA4T
         JoQJNB9b2bcc5aTb/hVGJrwtIWpFtYqgCe735YCYcLTuWeE9EQhNTJ1jRy7975So/KJL
         E7lg==
X-Gm-Message-State: AJIora+Y1ZG6bM0qmZl5afIVdI20IETBFjOABmo6yxIssuggb8PWDVlh
	qk0rx7lXMRIXmQyQZtfQKOG176ZgD/c=
X-Google-Smtp-Source: AGRyM1tBLB65vs7z2SDLLQzHcoLXeS4s75YEEkQtsEzYJFZObAFUc8s1amJX5f2oY1ZUkTo+jWuV6Q==
X-Received: by 2002:a17:90a:1117:b0:1f0:5361:1712 with SMTP id d23-20020a17090a111700b001f053611712mr5387104pja.239.1658937629330;
        Wed, 27 Jul 2022 09:00:29 -0700 (PDT)
Received: from [192.168.1.105] (h208-100-169-68.bendor.broadband.dynamic.tds.net. [208.100.169.68])
        by smtp.gmail.com with ESMTPSA id v2-20020a1709029a0200b0016d2db82962sm13736640plp.16.2022.07.27.09.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:00:28 -0700 (PDT)
Message-ID: <48d7cb4fb902055f2861bbe773590d2397f98baf.camel@gmail.com>
Subject: Re: [PATCH 04/10] wiphy: fix runtime error from bit shift
From: James Prestwood <prestwoj@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Date: Wed, 27 Jul 2022 09:00:28 -0700
In-Reply-To: <570bd0eb-db94-f0f2-2a76-f9bdbc014b3e@gmail.com>
References: <20220726170920.15929-1-prestwoj@gmail.com>
	 <20220726170920.15929-4-prestwoj@gmail.com>
	 <570bd0eb-db94-f0f2-2a76-f9bdbc014b3e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2022-07-26 at 15:57 -0500, Denis Kenzior wrote:
> Hi James,
> 
> On 7/26/22 12:09, James Prestwood wrote:
> > The compiler treated the '1' as an int type which was not big
> > enough
> > to hold a bit shift of 31:
> > 
> > runtime error: left shift of 1 by 31 places cannot be represented
> > in
> >                 type 'int'
> > 
> > Instead of doing the iftype check manually, refactor
> > wiphy_get_supported_iftypes by adding a subroutine which just
> > parses
> > out iftypes from a mask into a char** list. This removes the need
> > to
> > case each iftype into a string.
> > ---
> >   src/wiphy.c | 48 ++++++++++++++----------------------------------
> >   1 file changed, 14 insertions(+), 34 deletions(-)
> > 
> > diff --git a/src/wiphy.c b/src/wiphy.c
> > index 09b99fb2..98bd3aa4 100644
> > --- a/src/wiphy.c
> > +++ b/src/wiphy.c
> > @@ -707,17 +707,16 @@ bool wiphy_constrain_freq_set(const struct
> > wiphy *wiphy,
> >         return true;
> >   }
> >   
> > -static char **wiphy_get_supported_iftypes(struct wiphy *wiphy,
> > uint16_t mask)
> > +static char **wiphy_iftype_mask_to_str(uint16_t mask)
> 
> I'm still unsure why you introduce this? Can't you use 
> wiphy_get_supported_iftypes() as is?

Only to avoid passing the wiphy pointer to all these print functions.
Otherwise yes, the original could be used as-is.




