Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3670C2747A
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y40PU+y+"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-41cb9419975so13411751cf.2
        for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 08:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697728994; x=1698333794; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bw7cvOWg9VHXTVJeZxJVumky8PN7RqQbuWPQxr2ywPE=;
        b=Y40PU+y+NFx3R1H2JycQmX/NU8BAr6ROKIIlV9jQ4lFvWKrdmawuUOPFxNHoFKYGlz
         YLlQqSPYL8kyWOB3gCVNYwlWT7NggvPCynFLLP16hFhegJSnA1r6Y+xFBo+8rxQluTaZ
         x5KFgfBGYLlaI7ByXPItT1p4yGpBskRZFwQgWX6lNxGzi8L8YyScj65ggBwszRUpA7t4
         XqS9IPYdX0I9DhwiBhR2QUKG64l+YyXMYVW2FeFlIZmtOVqIeCqsr29YB8G/Xc03XH4A
         NtdEnjtORrGxNiKKV7RopaShjje3ac1c5eXhY+6w2q0Z6V2wHQDBMbIQN1Xm8eeea+lw
         iWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697728994; x=1698333794;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bw7cvOWg9VHXTVJeZxJVumky8PN7RqQbuWPQxr2ywPE=;
        b=nHu2SJirouN1HEE3dtaK3Tau8oM0wlSPqK6zk5+kCupOuZwkjKsPg7/zjbKUKmuxna
         ElSzMqOSEjhXwhaauisVWGwgP0nbltsS7IfnM5b/HOpjzJgtzNdBdSnBxaZfbYWzceNb
         6v0oycBVno5mrkyIayFOsSVtRrkZgiFJtM0sOOknd1Ekl5MQDflMx9AkWHRzAqBKwZka
         FQ+kGoptdt5s1WxFxaF829rtz7gSBKhfGl9R8phNNIBqFjaypChloBZlMm+7COIve7Z2
         fDnyTzBpDPCv9o9UFQfwG58qb+5qgh7cd59+tqIaHQLUORp2Cyd+xpYJQXyXZ+QBD2Zy
         IEdQ==
X-Gm-Message-State: AOJu0YzyvLRbTtNSK2ScsMwHM0GBeqzqcdNNgiXGhh3uxPWWPoDlHIHh
	83iRYOYocqObG9QvR6qJREBqWwW7iOU=
X-Google-Smtp-Source: AGHT+IH58hd3o0zQaJTduBTNU7pU4ZGPXGHM0UTXi8YvJ8D2iY8f0tPiLSySlyOQppEpwB188szF1g==
X-Received: by 2002:ac8:5fd4:0:b0:417:bb63:e41c with SMTP id k20-20020ac85fd4000000b00417bb63e41cmr3202634qta.58.1697728993870;
        Thu, 19 Oct 2023 08:23:13 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id cp6-20020a05622a420600b0041b7f89ad19sm806277qtb.53.2023.10.19.08.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 08:23:13 -0700 (PDT)
Message-ID: <0dd4a4a5-95aa-49c1-be77-e640862c3f82@gmail.com>
Date: Thu, 19 Oct 2023 08:23:10 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/21] doc: PKEX support for DPP
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-12-prestwoj@gmail.com>
 <41078822-99da-466e-b612-91a8c223dbde@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <41078822-99da-466e-b612-91a8c223dbde@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 10/19/23 7:59 AM, Denis Kenzior wrote:
> Hi James,
> 
> On 10/12/23 15:01, James Prestwood wrote:
>> PKEX is part of the WFA EasyConnect specification and is
>> an additional boostrapping method (like QR codes) for
>> exchanging public keys between a configurator and enrollee.
>>
>> PKEX operates over wifi and requires a key/code be exchanged
>> prior to the protocol. The key is used to encrypt the exchange
>> of the boostrapping information, then DPP authentication is
>> started immediately aftewards.
>>
>> This can be useful for devices which don't have the ability to
>> scan a QR code, or even as a more convenient way to share
>> wireless credentials if the PSK is very secure (i.e. not a
>> human readable string).
>>
>> PKEX would be used via the two DBus APIs on a new interface
>> SharedCodeDeviceProvisioning.
>>
>> StartConfigurator() will start listening and wait for an
>> Enrollee to send a PKEX exchange request.
>>
>> StartEnrollee() will initiate the exchange.
>>
>> PKEX would proceed and once done DPP Authentication will start
>> using the boostrapping keys exchanged.
>> ---
>>   doc/device-provisioning-api.txt | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/doc/device-provisioning-api.txt 
>> b/doc/device-provisioning-api.txt
>> index ac204f46..4c0ecb28 100644
>> --- a/doc/device-provisioning-api.txt
>> +++ b/doc/device-provisioning-api.txt
>> @@ -71,3 +71,33 @@ Properties    boolean Started [readonly]
>>               Indicates the DPP URI. This property is only available
>>               when Started is true.
>> +
>> +
>> +Interface    net.connman.iwd.DeviceProvisioning [Experimental]
> 
> nit: [experimental]
> 
>> +Object path    /net/connman/iwd/{phy0,phy1,...}/{1,2,...}
>> +
>> +        StartConfigurator()
>> +            Start a PKEX configurator. IWD must be currently
>> +            connected to a BSS and have at least the
> 
> To a network?
> 
>> +            [Security].DeviceProvisioningSharedCode option set in
>> +            the network profile. An identifier can be set with
>> +            [Security].DeviceProvisioningIdentifier.
> 
> I would think [DeviceProvisioning] SharedCode and Identifier?
> 
> But I do have to ask, this is used for PSK networks where profiles are 
> rarely touched by the user.  Do you really expect someone to muck around 
> in them?  I wonder if autogenerating such codes / identifiers or an 
> Agent API is more appropriate?

Autogeneration really won't work since both peers have to match.

For my needs the code/key is baked into the device image (i.e. a config 
file) so putting it into the .psk file would work great mainly because 
IWD could encrypt it (by adding "DeviceProvisioning" to the list of 
groups for profile encryption).

But for a human user the shared code does make sense to come from an 
agent, or the StartConfigurator() API itself. The use case here that 
comes to mind is sharing wifi credentials when your PSK is a very secure 
random string and you don't want to have someone type that in.

Could we support both like how we do with PSKs already? If not in the 
config file ask the agent?

> 
>> +
>> +            Possible errors:    net.connman.iwd.Busy
>> +                        net.connman.iwd.NotConnected
>> +                        net.connman.iwd.InvalidArguments
>> +                        net.connman.iwd.NotConfigured
>> +
>> +        StartEnrollee(a{sv} args)
>> +            The 'args' dictionary contains parameters for the PKEX
>> +            enrollee.
>> +
>> +            string Key - The PKEX key. This is required and must
>> +            match the configurer's key.
> 
> Why is this not symmetric with Configurator role?  I assume this should 
> be SharedCode?
> 
>> +
>> +            string Identifier - The PKEX key identifier. This is > 
>> +            optional, but if used both the Configurer and enrollee
> 
> Configurator?
> 
>> +            must use the same value.
>> +
>> +            Possible errors:    net.connman.iwd.Busy
>> +                        net.connman.iwd.InvalidArguments
>> \ No newline at end of file
> 
> Regards,
> -Denis
