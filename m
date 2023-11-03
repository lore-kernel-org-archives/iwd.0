Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074C814F9F
	for <iwd@lists.linux.dev>; Fri,  3 Nov 2023 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYgZgFhC"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7781b176131so106528585a.1
        for <iwd@lists.linux.dev>; Fri, 03 Nov 2023 04:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699010857; x=1699615657; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VxgZu7p2NnNKkL+pIQMmMSMq6gYi9+AI4o9zPEj2RLE=;
        b=lYgZgFhCJiBvCDvS4J6dxHpraWHk0DYx7aOGPtZEMlgZr+A3qoa4X4a+iQm+ryVZ+q
         eXN8GaKcjUPdYsXwr/qxpNLyIVLZ/kYM0dePzuvxHxtxwHjlL+yEKzfco+9lnvI//qlE
         4xPUXRJrCB/PdpiOwgWrVBLsExwQuJFRFQ6GSW8/M7bSi/SP5yXCYn6Cc7s2Gcs4Cr0w
         yCvM63xgxs/uKv2+XF/EvX6DJH2ch8ZfxStoPJZAsjkptgOvLV3HUE3E2Y90GMpzn+aH
         VKPlAQuagz2hBuZfPP1CTud3jBR7OdHDzTobDL/nuU3UGTR8QjtwDXycNaEEj8dLLS/2
         VXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699010857; x=1699615657;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VxgZu7p2NnNKkL+pIQMmMSMq6gYi9+AI4o9zPEj2RLE=;
        b=juem5IgvlLNtSXHi0BXw7BFysJRT9HNaP5p7cuR2LHj0bKYRZAxVRHIZ91HYPXq1U1
         1MDZgTuV72a5tjSjsGeh2vMvLxSK+FG1KbLe31nw/GCm6KGon06SEkl8nf+oxcWXQehq
         Uo9nf6xYpYQyM9hvmWjDoy80ddsNm+DJtbP5jtairOcNka17Z94xOY4WRh909tDfzU2f
         Y516uRXoJRm/0kdJo3QVb3LQTDSU7HzN0yN4LdslJryA1KKe+oe9REpnTe6i58Yo8Jty
         Bfd584BsG6rznHVjGzkoKPqAhaafaUtkB4JTUfkEFmbuD6mqsrD/5p0NDO4eWoBJkkdv
         Cx/A==
X-Gm-Message-State: AOJu0YxHu7B32xB12ZXazWJT2bQSzFKqWovoRqHBNLV7z6WLJPmqiW9m
	eNVh2RdlRaUf3MkEDiiXwpU=
X-Google-Smtp-Source: AGHT+IGA8i1yqqt6iOL8+WAOGcu1ZFh6RC0C+X3wvUEyJZVn/6DnRYOlYfpG0KP6ZKveSg33dxpk0g==
X-Received: by 2002:a05:620a:1337:b0:777:fec:5741 with SMTP id p23-20020a05620a133700b007770fec5741mr20252141qkj.33.1699010856856;
        Fri, 03 Nov 2023 04:27:36 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id 25-20020a05620a04d900b007756d233fbdsm640723qks.37.2023.11.03.04.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 04:27:36 -0700 (PDT)
Message-ID: <f82d0756-53a8-40aa-9ee7-0cee6f384640@gmail.com>
Date: Fri, 3 Nov 2023 04:27:33 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] dpp: initial version of PKEX enrollee support
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231031184750.722404-1-prestwoj@gmail.com>
 <20231031184750.722404-9-prestwoj@gmail.com>
 <1d8a3e83-defc-4f81-b85e-6ec0f59b4f18@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <1d8a3e83-defc-4f81-b85e-6ec0f59b4f18@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 11/2/23 7:12 PM, Denis Kenzior wrote:
> Hi James,
> 
> On 10/31/23 13:47, James Prestwood wrote:
>> This is the initial support for PKEX enrollees acting as the
>> initiator. A PKEX initiator starts the protocol by broadcasting
>> the PKEX exchange request. This request contains a key encrypted
>> with the pre-shared PKEX code. If accepted the peer sends back
>> the exchange response with its own encrypted key. The enrollee
>> decrypts this and performs some crypto/hashing in order to establish
>> an ephemeral key used to encrypt its own boostrapping key. The
>> boostrapping key is encrypted and sent to the peer in the PKEX
>> commit-reveal request. The peer then does the same thing, encrypting
>> its own bootstrapping key and sending to the initiator as the
>> PKEX commit-reveal response.
>>
>> After this, both peers have exchanged their boostrapping keys
>> securely and can begin DPP authentication, then configuration.
>>
>> For now the enrollee will only iterate the default channel list
>> from the Easy Connect spec. Future upates will need to include some
>> way of discovering non-default channel configurators, but the
>> protocol needs to be ironed out first.
>> ---
>>   src/dpp.c | 765 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 761 insertions(+), 4 deletions(-)
>>
> 
> Wish this came before the agent stuff :)

Yeah, I can reorder them. I did this really just to include some of the 
cleanup functions that only made sense once the agent existed. But I can 
leave them in this commit.

I can also split the configurator patch into two, one implementing 
ConfigureEnrollee() and the other StartConfigurator()

> 
>> diff --git a/src/dpp.c b/src/dpp.c
>> index 57024a26..8b47be5c 100644
>> --- a/src/dpp.c
>> +++ b/src/dpp.c
>> @@ -53,10 +53,12 @@
>>   #include "src/network.h"
>>   #include "src/handshake.h"
>>   #include "src/nl80211util.h"
>> +#include "src/agent.h"
> 
> Why is this needed?
> 
>>   #define DPP_FRAME_MAX_RETRIES 5
>>   #define DPP_FRAME_RETRY_TIMEOUT 1
>>   #define DPP_AUTH_PROTO_TIMEOUT 10
>> +#define DPP_PKEX_PROTO_TIMEOUT 120
>>   static uint32_t netdev_watch;
>>   static struct l_genl_family *nl80211;
> 
> I'll look at this in more detail once you send v4.
> 
> Regards,
> -Denis
> 
