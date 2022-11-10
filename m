Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7236E2F5A
	for <iwd@lists.linux.dev>; Thu, 10 Nov 2022 15:22:13 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-13be3ef361dso2446504fac.12
        for <iwd@lists.linux.dev>; Thu, 10 Nov 2022 07:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3CPmOTJcEPEFw+SfWU4ImFfcG/er57VWgc6DxIgs44E=;
        b=GQJHPhYThyeKpmxqKd0JVzRGgmMAvfCX4ZJNbOVH9SMLD8freZ8Au5487csDy/SY6z
         zmXFzc4f0sJSt+KeG67X8CSmxIPpmY/st9lxuUWo2709vaFfPwr9yaMc8X3zQP0yMw6z
         Vyi1mQPpmQdAOerwvZvfJ5WbMq1rFg03Rme0slPr/7TjeTjGRI4VP76B0rBk0AONxFcj
         EO1CB6Zq1jEangYAxL99hhLUNZzoJNGy3sxsM7lxUVDiEi1WCsHSNUvmMSMlFvM5Rk4/
         ih1A2gse7F6G3AUcMy7jaouNUPqnl7up4x01eAB4tgDJ49ddy2pTEvSxtcjLuqnqEsbN
         YCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CPmOTJcEPEFw+SfWU4ImFfcG/er57VWgc6DxIgs44E=;
        b=mElr1NyRDPn/KAkk/B8Xd+tISXhZQP6M0i5ms3wqyR/jtKr1zlaq+0UYK4/ACLzQTC
         8IntFO7wUCKoIwO8O+JmVi3WpAehaVMHdGfLxe9f/xn7a0XiQ85FP/BwCoSj2F2xZ0xT
         Ya/UJ4AIWHUrTGDoJR/fHLrq/4vgSpGAMlSeNh9cHWyR6Au62suQCMeKANGjrvtcS3mz
         X3ddNYKPOpC902Muwi/pNHGLdlgOBTh9QfzuQ5qXYyEW5LkTed/eAohmpKOSUS0Erp1I
         1IiHrTg5M5kS8hOvd4q5cWGU3pUqK8BeJOzvv5s/oG3kSDl9cOpHyVpMrAXba+/L7HtH
         b9eQ==
X-Gm-Message-State: ACrzQf3GK15CKRFBagJepQp3V1GE1o2WDf7lS/5pybAgy/oOZN4YY6FF
	GIdiZJ2mlc2RF0q0A1uG0hm3DUS16ws=
X-Google-Smtp-Source: AMsMyM6JYTVs0iKNcSi+Sgtn3LuIwOqU39gdT2oFfp5Xwe4/0dsMDD+LxI+aIEVS7tbPBis2TWGEeg==
X-Received: by 2002:a05:6870:a543:b0:13a:e87f:218b with SMTP id p3-20020a056870a54300b0013ae87f218bmr1642591oal.211.1668093732454;
        Thu, 10 Nov 2022 07:22:12 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id e10-20020a4ae0ca000000b004908a9542f8sm4483938oot.31.2022.11.10.07.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 07:22:11 -0800 (PST)
Message-ID: <64d42db4-6978-60a9-b70e-f2a27d471065@gmail.com>
Date: Thu, 10 Nov 2022 09:22:10 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Permanent disconnect when deauthenticated during a roam
Content-Language: en-US
To: Michael Johnson <mjohnson459@gmail.com>
Cc: iwd@lists.linux.dev
References: <CACsRnHU1WkovQrSUFH91haGf7rJJppfBwCxkVT9eXejVk_CJ1w@mail.gmail.com>
 <e5a311c2-eb02-d31a-f9cf-b8101089018b@gmail.com>
 <CACsRnHWoXyrmxvAaQg-5n3GOpokdk67rtDTuv=c7cTV8mgvazw@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CACsRnHWoXyrmxvAaQg-5n3GOpokdk67rtDTuv=c7cTV8mgvazw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 11/10/22 03:20, Michael Johnson wrote:
> Thanks Denis,
> 
> I'll give the patch a try. When you specify 1.30 does that mean this
> isn't likely to have an effect on 1.28?
> 

Should be applicable to 1.28 as well I think.  I just didn't look that far back.

Regards,
-Denis
