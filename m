Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F28832
	for <iwd@lists.linux.dev>; Mon, 17 Apr 2023 19:35:45 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id fv6so12858570qtb.9
        for <iwd@lists.linux.dev>; Mon, 17 Apr 2023 12:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681760144; x=1684352144;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1A4no555S/oe8r8RTsy0mV3CyStwB/YeXkWtfo7gOUs=;
        b=GsaESztxOL09ZpfxKt88/arRT+DrNVlvKze5BOgRZeYTP46q0HkSUpM4U+IEZ5988H
         C2VKfILAi9IOhMagX+Sha+1+OLFDVMfLht5GRVrS5zv8b+1qjmPyTwQ7XUm3xhwvCT9c
         jhp1lSe9tRJNmlqQzY2/8bDJCdRRnwnZHvlkE5PnHz32zm6bGoz/XvvfMHIfl2Fz0Voo
         n8JKgg1Ck77hpz2ejIwCc0JMhdJkWeuJfHWi2FuTK00FEsXaCN6KJmeqOAJ2zs1DL4ce
         RPn/7i7vEVWUW2drA9aRg0IJ4vAgV1J9EMlzIKAsvhBFSj9WJsNLHngZGGh5S/v19sCn
         j8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681760144; x=1684352144;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1A4no555S/oe8r8RTsy0mV3CyStwB/YeXkWtfo7gOUs=;
        b=Hf7gBLbgbKmRLg9JWecicdE9L9TO2uVxJc4NhoZ7nGLQpVac5chInyhe9UNrLQgC7f
         /D2Co+AjBX8wkLQOnLINH4zYNKDn5pWZ+KLsafCIwW1Vc8JuPzJnVN8Yz0o00MSvh+/E
         fo3goYUht5XlGO4dnXqle5SkIFjSHh5hp0hakMjcFqgNrt+W4iAIIQXtQkml+WA1VECn
         9b2mWogjRM5U3IB9GJyoSe52Um+Ah0THOXqYkjmsOP916mWYOJNyqRVh+YEEkSOqvaQ5
         nhN2kXhfRw6piZ8czsrU4L2Aq+V1nDiRfjhzwVjGzAlsjeeXixtP86VFboKFghLlkTbi
         xE8g==
X-Gm-Message-State: AAQBX9eyLgvtGBArQWil97oxp1tthy0i93Eb7NsEExL2dApgMl/Cxh3f
	pVpOkbHPugKo5od9zm2OHcXnCvPvwac=
X-Google-Smtp-Source: AKy350Z1ZJU1MteTRBkFNtyD0vJxn1VbPMuFDc1wga9SClsXpZkrUMwqIFBJlKWQfubWrMZxasIywg==
X-Received: by 2002:ac8:7e87:0:b0:3e4:488c:9325 with SMTP id w7-20020ac87e87000000b003e4488c9325mr22415937qtj.15.1681760144462;
        Mon, 17 Apr 2023 12:35:44 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id l18-20020ac87252000000b003bf9f9f1844sm3483828qtp.71.2023.04.17.12.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 12:35:44 -0700 (PDT)
Message-ID: <3855c8ce-c2de-d1f3-e5d8-8c93610e4b22@gmail.com>
Date: Mon, 17 Apr 2023 12:35:41 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID
 generation
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230404203823.384260-1-prestwoj@gmail.com>
 <1d8a1939-93fe-12b6-5007-e6621dffa7f1@gmail.com>
 <f3259b4c-e8e3-8542-247b-9d6bd0ad00af@gmail.com>
 <05e63c78-5373-520c-15db-aa42cecd95b0@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <05e63c78-5373-520c-15db-aa42cecd95b0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/16/23 9:37 AM, Denis Kenzior wrote:
> Hi James,
> 
>>> However, one consequence of this is that preauthentication is likely 
>>> broken for FT-over-8021x networks?  Do we even test this case?
>>
>> I don't think we have this problem, 802.11 disallows preauthentication 
>> for FT networks:
>>
>> "A STA shall not use preauthentication within the same mobility domain 
>> if an AKM suite type for which the Authentication type column 
>> indicates FT authentication"
> 
> I'm not sure I concur with this interpretation.
> 
> The AP can advertise both FT+8021x and 8021x.  STA can preauthenticate 
> to such an AP.  It can then connect to this AP using PMKSA caching, 
> potentially selecting FT+8021X as the AKM for the initial association.  
> Table 9-151 even hints at this: "0 (open) for FT Initial Mobility Domain 
> Association over IEEE Std 802.1X or PMKSA caching".

Yes I suppose then preauth + FT is broken, or at least incompatible 
depending on hostapd version... but fixing this is somewhat impossible 
right? We don't really have the opportunity to try both derivations 
since we don't know what the AP used (unlike eapol where we have the 
PMKID KDE to reference).

> 
> What you quote is a requirement on the STA side not to use 
> preauthentication if the _current_ association is not an 'initial 
> mobility domain association'.  In other words, if we used FT to get to 
> the current AP, we can't use preauthentication within the same mobility 
> domain.  This makes sense:  Why would we use preauthentication if FT is 
> available.
> 
> Besides, there's still the case of IE_RSN_AKM_SUITE_8021X_SHA256 (and 
> the SUITE_B ones which we haven't enabled yet).  That needs to use SHA1 
> in the case of preauthentication as well. >
> Regards,
> -Denis
