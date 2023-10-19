Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CE22FE0F
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klJRr0OB"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ce2fc858feso19072a34.3
        for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697741767; x=1698346567; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axvcTnb6i82BQSdXpO1rs2smVvo8by/lZ3Zx0WBB6tI=;
        b=klJRr0OBfr0rqty+1WXrE55/EIOUnIQQDZoknJO8PBIgMG/MXuU8Ng80pLuk8jIihe
         XvYlic4QkbxZsjMxYRqWmlFb62INFVzwOaHKaFQqOhEFLXfFsPsqtLqmsQBWVXHdl7GJ
         2HBoDAxAubtYi1JOCgc9p64lTb/3iELAzA/HoEnnpslslEPkyv5s82rj8kP265D7Z2Hr
         ik8nnXwKf7jVEG6svljS2WxUpobTtg68fjgJCZFDvJz+nKI8UnFH8OwqX8ZmVI1ZvUVU
         xChX0MIi07+YQnHGace9/IYCGH0CP/taJZpdBrYLQUESuMsgULKljdYXKaelwC2E7twh
         10Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697741767; x=1698346567;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axvcTnb6i82BQSdXpO1rs2smVvo8by/lZ3Zx0WBB6tI=;
        b=MNnzsiRdXFPfiSl9mBuTAwTXldSQm+TP0LjwVIzk6iV1H4C/08iC7rsnfEXKuoPfhL
         0U0aS5fSVyE8UGEq4lHOXWCEUlD2VvA2829ZnXIMdaqMuuiU0Alae2rRKfn4SRb3Ho9X
         UCXZTVOC76S2e+Od75FvowcRZqr9FH2jNgKIw06L6hFZ9JvJD4icYispOQ90oBFl7CSS
         LxZi1bx/4YC9WZykPxiGq1+HwEmC4arWTdI/+NrsFIz3Zwq9letVubN9Q93tTVXEfd7u
         6RGJ1LvsLGxkxHXQzywQwcj/n9X+uGhyj3L3nVSdDuHUsmsXWJyId/yXKhKalGS9s3QY
         fLgA==
X-Gm-Message-State: AOJu0Yyl4gisc1KR3JOtW9wRSPDwBiWaglSQJL4MEk9sEOhTU+ss/eru
	/Xed0hCLjPEFwKCFTBEwAv0=
X-Google-Smtp-Source: AGHT+IE+uIp4BhauVX6GDamOurU3oWIaOl4Lk6TkbiDXv9uQUVZn1dwOKdQbePMvIntnh3JJXTVMAg==
X-Received: by 2002:a05:6830:44a0:b0:6b9:8feb:8337 with SMTP id r32-20020a05683044a000b006b98feb8337mr3629047otv.9.1697741767293;
        Thu, 19 Oct 2023 11:56:07 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s5-20020a056830148500b006b9443ce478sm31650otq.27.2023.10.19.11.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 11:56:06 -0700 (PDT)
Message-ID: <c8617f8d-0c7c-4e1c-ab0f-f356a121afe6@gmail.com>
Date: Thu, 19 Oct 2023 13:56:05 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/21] doc: PKEX support for DPP
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-12-prestwoj@gmail.com>
 <41078822-99da-466e-b612-91a8c223dbde@gmail.com>
 <0dd4a4a5-95aa-49c1-be77-e640862c3f82@gmail.com>
 <62d0c420-3bc5-45a8-80c6-c4c59db7ae2c@gmail.com>
 <d69dd453-95b8-49b0-9419-3ee0c7c98fe1@gmail.com>
 <a38fc175-3095-488d-a0ea-a70e7f148540@gmail.com>
 <035c5cb1-d5be-4c4b-a6f5-8c0941926225@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <035c5cb1-d5be-4c4b-a6f5-8c0941926225@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> 
> I guess my question is really how you communicate this to the enrollee.
> 
> The use case for a human user really comes down to not wanting to type in a 64 
> character hex string :) So auto-generating a complex code doesn't make much 
> sense in this regard.

Who said anything about a 64 character hex?  I'm thinking more about a 10-12 
character complex password like you see the web browser generate.  However, I'm 
pretty sure we need the ability to generate the code every time:

"If both sides have a user interface, this technique can be used to bootstrap 
trust by exchanging bootstrapping information including the bootstrapping keys 
that are to be used for a DPP exchange requiring mutual authentication. This 
bootstrapping technique shall use a fresh code each time and the same code shall 
not be used with different Peers."

Correct me if I'm wrong, but PKEX is no different than regular DPP.  It simply 
uses a code instead of a QR code for establishing the initial trust channel 
(giving high degree of confidence to both parties that the exchanged public keys 
are trusted).  The more complex the code, the better the chance that the code 
can be trusted (i.e. it wasn't guessed).  It still inherits the same basic 
attributes, roles, etc.


> 
> For a headless device auto-generation just won't work since the password is 
> baked into the image. I considered generating a single bootstrapping key and 

Doesn't this run counter to what PKEX is about?

> bake that into the image (no PKEX) but I question the possibility of offline 

With a strong password, probably eons, unless quantum computing is involved.

> attacks. With PKEX the bootstrapping keys are changed upon each protocol run so 

But you're still sharing a PSK in the end?  Why go through all this trouble?

> I think there is forward secrecy there. Plus PKEX uses mutual authentication to 

WPA3 has forward secrecy as well.  So what are you trying to achieve?

> prevent someone from coming in and configuring the new devices who shouldn't be.
> 

The gold standard is still WPA-Enterprise with EAP-TLS.

Regards,
-Denis

