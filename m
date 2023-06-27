Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D99C19501
	for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 14:30:43 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-76714d3c3a7so30706885a.3
        for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 07:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687876242; x=1690468242;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRQQN3GA761LNfTEh2mcLS5SCrklG3auH/svqioHPxo=;
        b=oesWwEWBEJPvr5ZMsSHI7Eu+oqQkb8dvemPwz6BCZMZ7J3HFJPxsJ8h+EHw6H38f7R
         SCABQ5s575TdwLgrri0+YKTQ7Cm/wS4TXITaW4TrvJfaHxcz5gipkYC0cuVjLN+DOJ/v
         83xgAR7/4dk9fE3qRPTKVqF7EjwAB/2hvIY+ns5OqpfIq7rs4pvoOVJLJp6WmM3QBXhX
         RmJoY7M4C69+NV33SCbTPzfFteGMAabZx5C+TTz6ZO3EWYlN7B1qUSteiQ9JWP9TfrKy
         zEAEOHsMCSxlEsFP33Wr8kcKcDJWG+oOkoDHL9i/boB+nGmq8vH4IEJoUiPoLS4MW6vq
         56yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876242; x=1690468242;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRQQN3GA761LNfTEh2mcLS5SCrklG3auH/svqioHPxo=;
        b=bfPLdkVIKwmzUHQQbAcMcEZwrbpK/ElJzTqG9073/9YIiCbqu5yLey4WWkE0+eWQcH
         0wWEsZjpbbQ/xcpQ4LjjdcYCQxOngde1G458P0FEy+ewtgr11DNxgazDXOVnWPZ3IOzF
         mkIz9xfVLpWhLOs9VQBGRF+c89nvjvM0CXQppIY+iGwN4+BWWqqu/ICyyx213cSHo6FW
         fos6WHY3C/urymjn4Q9Fe0y3MoDuyz5DDqawuDfWAL0wdMHul/6qisPFivGE3+z9syER
         v3VlOvKj7PiRl9xFzCBkboQ8xKNlmqtndMsgLY6PnOzZWG8rGoPSs/Myjit86Sd/oHcF
         FCZQ==
X-Gm-Message-State: AC+VfDyStFPWG08k1hKLEC0SU6SnqiCLgiG9lUVGKryvoII2ITLTcQ/x
	7BVjT+QdEqmeO6x9omL/TC0=
X-Google-Smtp-Source: ACHHUZ5wHxgu3hypmfjQ7iQpdoCfbVwS9FlXiG7DMfDMkz4qEWs8a+6Jw9oWjJ2KVviPJQJUAkLnZw==
X-Received: by 2002:a37:ab1a:0:b0:765:48af:ded5 with SMTP id u26-20020a37ab1a000000b0076548afded5mr12906140qke.11.1687876242190;
        Tue, 27 Jun 2023 07:30:42 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id r15-20020a05620a03cf00b0074e0951c7e7sm4020200qkm.28.2023.06.27.07.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 07:30:41 -0700 (PDT)
Message-ID: <363127fe-f545-b09a-07ab-ce1334cf99b2@gmail.com>
Date: Tue, 27 Jun 2023 07:30:38 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 0/3 v2] PMKID changes
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230620172533.727504-1-prestwoj@gmail.com>
 <061334b2-e4eb-dcf2-275d-fc604909c9cf@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <061334b2-e4eb-dcf2-275d-fc604909c9cf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/26/23 7:59 PM, Denis Kenzior wrote:
> Hi James,
> 
> On 6/20/23 12:25, James Prestwood wrote:
>> v2:
>>   * Pass checksum type to handshake_state_get_pmkid
>>   * Added back in comments regarding AKMs and SHA sizes
>>   * Moved comment regarding preath/SHA1 into station.c
>>     where SHA1 is passed directly
>>   * The older discussion from past patchsets about preauthentication
>>     was mostly left out as it pertains to when you choose preauth
>>     as opposed to the SHA sizes that this patchset is about.
>>
> 
> All applied.  I changed the wording of patch 3 description slightly 
> since it referred to forthcoming patches that I assume are no longer 
> needed.  Please make sure you're fine with the verbiage.

Yep, LGTM

> 
> Regards,
> -Denis
> 
