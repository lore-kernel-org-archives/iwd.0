Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40941D54D
	for <iwd@lists.linux.dev>; Thu, 14 Sep 2023 18:06:22 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d77ad095e5cso1339916276.0
        for <iwd@lists.linux.dev>; Thu, 14 Sep 2023 11:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694714781; x=1695319581; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nCwGrbl1uMQPB3yaBmjI9ev41wBFm3xwOZzjroR2Gf4=;
        b=MgNxZINXe8HOEGJ9JPzFwk73R7suFSeQWHnDaOrOJ+vs3ZxCgnUHl2VHvbwtAL3SLk
         WsMA4lzU0u24OCHPmewgrNRM2Po6poKl14YbNFeqsE5o3IK7R4gKWL9EHNJVVD73sx9v
         5JpQLutK/mdNs0JMUB1ETW9hUaQeefploZ5XmBnXIb7dQOt0LoiUvb14yfqtAJ+K3TfM
         zDagElXgg5VMNeAo7snIXAacb8/A0ePiQ/GBt3l2/0L5VM/0/mM7E4eCU8QzmFB/5XPP
         uUFpQtU3uOU/hWbQD+Oc4CKA8g3eN2NxXMN/fV6W70Na8HaKvy5zUw/RjHKu7sViMrtA
         lrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694714781; x=1695319581;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCwGrbl1uMQPB3yaBmjI9ev41wBFm3xwOZzjroR2Gf4=;
        b=at9MNpsEzimYDbb+6MKnUzqdD3xXslU6tUTCyilRFitq/Tm2fFVjbp1dzwXkKMCY1n
         OEn+GPvVNNIXVOXcnE+yc1CDno+zxLk+wgR2gRVz2+eVAVV8tT2LAqRFYwcoKnxeM3wY
         GoPlArCdhlIF36kNSAkiNFkf54zSDwsI2exl+6LlNGP/6+JtoDsvovFT6/FgRjjVa6iZ
         JM84nIJis8TG1tfUtX0sYCw/pK1U/q2+vmYUf00N/4+x69OF34EmqMOAZ9K+IbiOgMGh
         11v9jfc+/FN23Yswr4FcqaSp58ZptebLp6tt+r8yJuUtU8nTkpgQqBEED4FF1qX906P2
         9qaw==
X-Gm-Message-State: AOJu0YwBksiJ13t6FLqZ7wt4KDtBtIgxkPCnosUvQGUHcu3bBIcjHBic
	GCa6LgSTss4WzOm3CadJVZ93BA257Ig=
X-Google-Smtp-Source: AGHT+IH6S3H9Bhy2P/p2zJV3Mglt3B+STATUlUpHBXbnBBh7dQO/aLd6DcFzAnhFNGIQp1m6T4DZ8w==
X-Received: by 2002:a25:2904:0:b0:d4d:f8f4:e409 with SMTP id p4-20020a252904000000b00d4df8f4e409mr6353662ybp.57.1694714781301;
        Thu, 14 Sep 2023 11:06:21 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id e9-20020a259249000000b00d43697c429esm422447ybo.50.2023.09.14.11.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 11:06:20 -0700 (PDT)
Message-ID: <34795e04-66e4-4359-a6b2-59b3f47eaf64@gmail.com>
Date: Thu, 14 Sep 2023 11:06:18 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Force use of 5GHz band
Content-Language: en-US
To: =?UTF-8?Q?Jonas_Gro=C3=9Fe_Sundrup?= <cherti-iwd@letopolis.de>,
 iwd@lists.linux.dev
References: <cfdbbdb5774c4db1c8d3ec7d1e09e70e340f075c.camel@grosse-sundrup.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <cfdbbdb5774c4db1c8d3ec7d1e09e70e340f075c.camel@grosse-sundrup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jonas,

On 9/14/23 10:44 AM, Jonas Große Sundrup wrote:
> Hi,
> 
> is there a way to force iwd to use the 5GHz flavor of a specific wifi?
> I am aware of BandModifier5GHz, but even with setting this to 1000 I
> still end up on the 2.5GHz band. That band specifically, however, is
> unfortunately suspect for some stability issues I'm facing and hence I
> would like to force iwd onto the 5GHz band to see if the problems still
> occur. That proves to be difficult, of course, if iwd is picking the
> 2.5GHz band…
> 
> Even though I do see that iwd probably has the better insight into band
> stability from a signal-strength point of view, any chance of
> overruling iwd's internal mechanisms here? (Or should I just crank up
> BandModifier5GHz by a couple of magnitudes?)

All we have now is BandModifier5GHz which is multiplied by the computed 
rank. The stock rank is based mainly on a data rate computation which is 
theoretical, but uses capabilities and signal strength to estimate.

1000 is pretty high, so essentially your 2.4GHz BSS's would need to have 
a rank 1000x larger than the 5Ghz ones. So either 5ghz is incredibly low 
signal, doesn't support HT/VHT, or maybe the IEs are malformed so the 
data rate isn't being computed correctly e.g. (defaulting to basic rates).

Do you have debug logs of the scan results?

> 
> 
> Thanks,
> Jonas
> 
