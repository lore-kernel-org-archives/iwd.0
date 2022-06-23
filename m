Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C23C1FB3
	for <iwd@lists.linux.dev>; Thu, 23 Jun 2022 15:26:00 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so4475492otk.0
        for <iwd@lists.linux.dev>; Thu, 23 Jun 2022 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=7N7IpFNHJfw0swczQyRIUd7uSZSOMu+r/VEk69/5gwY=;
        b=BZan+mdMOQEmG/ivAhi/NrZ/FjZsDgMi/UVSGB113pLTuHhV/zCwzU6J8+De0fIIWn
         ulR2l//kyfAgyuTnkJMOItVBZFA8mCuugosNmGALPtKsvBDpeAlRhjogFPYLuLrGwJRV
         D3vcnHu3+IaCdy2BG7nZun9kxcYfSytnB8Xu+VSNBZPpVcpMWKaMvjdwhJNvKPRfSu3P
         pitB7LMp+vWtV9JrsFbA31xIGhShECUvkZoq7cS9g8bQIgBOUQgvebLmbt4ViA1rCTbJ
         /sMHzcXbEjzdvkRda7QwBd1vbKgZvQekW/1K/uQYl060Gn0V5ptOtO/4lqSrhkl3WUx9
         3mTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7N7IpFNHJfw0swczQyRIUd7uSZSOMu+r/VEk69/5gwY=;
        b=34TJ6jaBIGSr5RfkoRDeS31PYqzQ2gjGFUNRvS1dKEukG8j39iasVYV4B5A1RneDxs
         lgNcv2JFdtqbgHthZTa6HVIJwkgB1jrEBeei62yZH2Uyl295zyjWFoFjUAf+TOsVItzz
         mTY+fyKy8tScK9lgLDebcd7N3py6P/pKYwI0MnIDxs3Pyd7VKujcK8E0IabdQiY1H/aU
         wzdV627dlHqK8rK5Gg//vpnwg9hZAY3sr0reS+Xy+a4m54iFX9ZnuzVmcfBgvMEJl/FE
         ZZljuNQ9tclOJnhHwTpw3RwKQH21qDnBUuyBOFqNgrq0+koYcIs1EPWqv6g0165JADPj
         CvyA==
X-Gm-Message-State: AJIora802jY1bCsFEOqSMRfK+eBgzRuTqfX4PlG4WV7cMjBJXYQFDMzT
	fYnrYO2xTUCVhTiDFO9+nqw=
X-Google-Smtp-Source: AGRyM1vkpwCHZWtDtRbxpiT38W0pN/rZLteFAGvv2S2Gvm/YLzlALTVp5p7j9KVj7oNzGVH1uv+yeA==
X-Received: by 2002:a05:6830:630f:b0:614:d51e:23e6 with SMTP id cg15-20020a056830630f00b00614d51e23e6mr4002867otb.210.1655997959164;
        Thu, 23 Jun 2022 08:25:59 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u22-20020a056830231600b0061691db3807sm165451ote.23.2022.06.23.08.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 08:25:58 -0700 (PDT)
Message-ID: <3a979ba0-f18f-12ec-6437-87c95ec1f9e8@gmail.com>
Date: Thu, 23 Jun 2022 10:07:52 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Multiple IP addresses after failed roam
Content-Language: en-US
To: Michael Johnson <mjohnson459@gmail.com>, iwd@lists.linux.dev
References: <CACsRnHX4-Y93QsHz4W+gF7SkOV9u+snNiaDZv=8BOZ4Yz0YBcg@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CACsRnHX4-Y93QsHz4W+gF7SkOV9u+snNiaDZv=8BOZ4Yz0YBcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 6/22/22 11:39, Michael Johnson wrote:
> Hi all,
> 
> I have just encountered a client which ended up with two IP addresses
> on the wlan and I think it might be related to iwd.
> (Un)fortunately it is a rare occurrence so I can't get DHCP debug logs
> but I did have the general iwd logging enabled. Hopefully this is
> enough to be useful but if not I figured it was worth reporting
> anyway.

Ok, lets see if we can get to the bottom of this...

> 
> Basically, at some point the client was disconnected during a roam
> with the reason code "UNSPECIFIED". After this `iwd` immediately tries
> to reconnect but is refused a couple of times before succeeding.
> When it does succeed, the DHCP server attempts to give it the same
> address but the ping gets a return and so it assumes it is already in
> use. This is likely the client in question as no other client has been
> given the IP.

That is actually very strange since during the failed roam we see this:

Jun 22 13:26:33.016737 p3-6087 iwd[429]: src/resolve.c:resolve_systemd_revert() 
ifindex: 5

Which implies that we are calling netconfig_reset().  This should result in the 
address being removed by netconfig_remove_v4_address().  I wonder if this 
removal fails somehow?  Might be worth adding a debug to see if 
netconfig->v4_address is somehow becoming NULL?

> This was on version 1.21 + select patches applied (I didn't have time
> to validate the latest version unfortunately).

That version is getting a bit old and we did touch netconfig/station in some 
places since then.  But on the other hand, I can't recall anything that would 
directly affect what you're seeing here.

Regards,
-Denis
