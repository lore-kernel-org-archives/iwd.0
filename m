Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0F34A32
	for <iwd@lists.linux.dev>; Sun, 16 Apr 2023 18:14:45 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id m20-20020a4ae3d4000000b00538c0ec9567so3458616oov.1
        for <iwd@lists.linux.dev>; Sun, 16 Apr 2023 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681668884; x=1684260884;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jX7JI99HSvupAqKLQds7Vob9tw33L860brEVI6t731c=;
        b=eCN04wKhFWxrIRQj51cGHsJ+LVivW5CXDVtMMo2p6mdEIx3EM4P/2AkJg9qR9B38Mu
         eootJv07ucs1R+lhmC3D+Vapf9dZtcbL5zMKZvIp1cTqigxvEqIsKT7xEZVbcHNYcset
         AzRlr+2Tph7zkK4/gpJO4BfNOVXRxzKggnoopc+4DMg8N63z/PN7YG3Cv1HSN05y4mRM
         roBOw5rRlmueuFarHhhVdOY6FtAeShx/1pYqDV0RSyws4XtXlrlUct1kBKBguZv1h4XO
         WNRzUJ7uDC8HjZ4l6QMW7zB/p3SMjg1ihGZmh8rETE50AoKKQED3dVKo2caKZGBO37di
         Pn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681668884; x=1684260884;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jX7JI99HSvupAqKLQds7Vob9tw33L860brEVI6t731c=;
        b=Jh/de4VHLXqHPl+rzsYC2f6PSXsxIJT4gIFdmQVy2IQSGsOqlYQVrjCGvUhooNCH+w
         tDor/y/c/7Klx6DTf0YNrmWkIeGHXEQORarpMC+QDDSFmmQWA211JzSz7zqwsCrm1/yH
         TDikY0DbyIMs2n+iMlrp+QmTXBvk+Qv7VCsn0Mjk8B/my8JHfU8hL5JCGAXQ7xdak2SS
         4NcPtB+llhV2gmztKt/B960awzBpFLwusb+oaqgI2SO8XXCMHSQaKT4eK2DYlrTsbs39
         F+dpimANhAtPRABdxfNGcyVifLRuZ44zPFQWFiiqK5ntSRIMJGVaTT7i1PpLkVDoZDbQ
         fXzQ==
X-Gm-Message-State: AAQBX9e/AQNB7UNRME/elbzapI3X9xU01b2w3p6L1eTDAsgr6GE0TlHi
	qJFYtmjQE7e3chyPAbOzhOdXF1m0J8dX1w==
X-Google-Smtp-Source: AKy350avheqMkIcztCMlLNBusHqqaq9ZxT2LvuZBRHHrMi4tSNq74uIwQjPvFi2cfS9yHv8mRv9vzg==
X-Received: by 2002:a4a:3309:0:b0:545:ceaa:9adf with SMTP id q9-20020a4a3309000000b00545ceaa9adfmr1632604ooq.9.1681668884519;
        Sun, 16 Apr 2023 11:14:44 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r7-20020a4a83c7000000b0054156478f2esm3898607oog.44.2023.04.16.11.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 11:14:43 -0700 (PDT)
Message-ID: <05e63c78-5373-520c-15db-aa42cecd95b0@gmail.com>
Date: Sun, 16 Apr 2023 11:37:16 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID
 generation
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230404203823.384260-1-prestwoj@gmail.com>
 <1d8a1939-93fe-12b6-5007-e6621dffa7f1@gmail.com>
 <f3259b4c-e8e3-8542-247b-9d6bd0ad00af@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <f3259b4c-e8e3-8542-247b-9d6bd0ad00af@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>> However, one consequence of this is that preauthentication is likely broken 
>> for FT-over-8021x networks?  Do we even test this case?
> 
> I don't think we have this problem, 802.11 disallows preauthentication for FT 
> networks:
> 
> "A STA shall not use preauthentication within the same mobility domain if an AKM 
> suite type for which the Authentication type column indicates FT authentication"

I'm not sure I concur with this interpretation.

The AP can advertise both FT+8021x and 8021x.  STA can preauthenticate to such 
an AP.  It can then connect to this AP using PMKSA caching, potentially 
selecting FT+8021X as the AKM for the initial association.  Table 9-151 even 
hints at this: "0 (open) for FT Initial Mobility Domain Association over IEEE 
Std 802.1X or PMKSA caching".

What you quote is a requirement on the STA side not to use preauthentication if 
the _current_ association is not an 'initial mobility domain association'.  In 
other words, if we used FT to get to the current AP, we can't use 
preauthentication within the same mobility domain.  This makes sense:  Why would 
we use preauthentication if FT is available.

Besides, there's still the case of IE_RSN_AKM_SUITE_8021X_SHA256 (and the 
SUITE_B ones which we haven't enabled yet).  That needs to use SHA1 in the case 
of preauthentication as well.

Regards,
-Denis
