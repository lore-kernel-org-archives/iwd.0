Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDD54A2C
	for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 18:21:27 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id b10so5042871pjq.5
        for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 11:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=JuSQidiizhG6IaGeJvuhcmFI+W7Tezt61vMemwYru1Q=;
        b=gzi6WqkwcjfpAQ6kfR97aGulvJktQqlg1ceQj8aCBcbcg07IE3qoj51lzt74jBwo11
         /b0IYIfxIxSTPWNOjBPeQwACLLuDj9dXVeh9ecE7nP9jiuTopvkhh7plS3nCC0kNboZY
         cGXPYE/eTGrKwT3K01R4xwNj23mQs03q9sCi7LRCtVqq011UwN81JvEEHO2tIazINedZ
         crxhefTVBzUpmkV0bfk3yVgtXiJvkqpEVJjY9uMnLqVgb6GiUkQRunFCcshaiN/StbJn
         kK4QUj5Tc03Dy/go79NW8PAiwWYQzUlhN3yFeT5bZijMtzu9pw6jY8kouTdtegLIF5eb
         bJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=JuSQidiizhG6IaGeJvuhcmFI+W7Tezt61vMemwYru1Q=;
        b=yFyXBKGC77TOYAtvDUXL1kBly6pOPH/5i7QCrU4Ie6LJ2eHeZQZD/6nDZf55uM8NWd
         T+rY8Vu8kkr3WUZ/NdjreBncBSmVKY+zLth7A0JUft+RdCP0gZaKWkfWvVpgtXi2Lf9g
         hJJ2a49NoXw3LGhD7khA5Z9JX+gW6+yFTNh0Ewv8Elu6Qt+6pItjeSZNzfp00nUwC0jY
         vMMUco28qcZjFYqjZMDMAVRYEg7J2F8Gat8n6FhR55cLMreUsyXP7QbjY5ucYFm6MIzH
         91+ryNn/o9peaVYfrJnGAg3q5UW+QhxylcBseHD9xlBXbGO2YTh9VD9KcIa4rblJ+Bm9
         x7VA==
X-Gm-Message-State: AJIora/V5NmD6QYGK8vC45k55NJh0pMYjFjCmQiVs7jRSrqLqc+pbS5j
	bfylR77mj8VTNnoUXue2LY0=
X-Google-Smtp-Source: AGRyM1u/aHwVzAghoErD+zAX+igVHcPsYlLDCVRJ926stseniEfP1hNn+fF2Vz46RYGXtlQk0AMaoA==
X-Received: by 2002:a17:902:ccc9:b0:16c:f878:163 with SMTP id z9-20020a170902ccc900b0016cf8780163mr752938ple.170.1658514087055;
        Fri, 22 Jul 2022 11:21:27 -0700 (PDT)
Received: from [192.168.254.55] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id d92-20020a17090a6f6500b001f2474a6683sm1946269pjk.38.2022.07.22.11.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 11:21:26 -0700 (PDT)
Message-ID: <80275819c01d45c8b53ca2bb6dabe6a3c8568b12.camel@gmail.com>
Subject: Re: [PATCH 1/7] wiphy: fix runtime error from bit shift
From: James Prestwood <prestwoj@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Date: Fri, 22 Jul 2022 11:21:26 -0700
In-Reply-To: <e144ecce-eaad-0156-4f9a-947c0b01b555@gmail.com>
References: <20220722163417.1119334-1-prestwoj@gmail.com>
	 <e144ecce-eaad-0156-4f9a-947c0b01b555@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2022-07-22 at 12:04 -0500, Denis Kenzior wrote:
> Hi James,
> 
> On 7/22/22 11:34, James Prestwood wrote:
> > The compiler treated the '1' as an int type which was not big
> > enough
> > to hold a bit shift of 31. Change this to 1ULL to fix the error:
> > 
> > runtime error: left shift of 1 by 31 places cannot be represented
> > in type 'int'
> > ---
> >   src/wiphy.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/src/wiphy.c b/src/wiphy.c
> > index 09b99fb2..4b9e130a 100644
> > --- a/src/wiphy.c
> > +++ b/src/wiphy.c
> > @@ -957,7 +957,7 @@ static void wiphy_print_he_capabilities(struct
> > band *band,
> >         uint8_t width_set = bit_field(he_cap->he_phy_capa[0], 1,
> > 7);
> >   
> >         for (i = 0; i < 32; i++) {
> > -               if (!(he_cap->iftypes & (1 << i)))
> > +               if (!(he_cap->iftypes & (1ULL << i)))
> 
> That seems overkill, wouldn't 1U be enough?  Or just make 'i'
> unsigned?
> 
> Have you looked into using wiphy_get_supported_iftypes() here
> instead?

Wasn't aware of that. Thats exactly what I need :)

> 
> >                         continue;
> >   
> >                 if (L_WARN_ON(s >= type_buf + sizeof(type_buf)))
> 
> Regards,
> -Denis


