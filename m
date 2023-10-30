Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E21513FE2
	for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxYhpwBl"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-66d134a019cso31452926d6.3
        for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 04:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698666972; x=1699271772; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I2EsWXgIgmY5ZGNZVcIKTU41YQY+qsuJewdFxQvk8sU=;
        b=RxYhpwBl/G7nhSpi+ZaS+i9r+jkGCafwqriXVXFPW5U/9XABwET8U1n2p2SfXd5rcM
         Rb60UEIcC2nD8DflTCq5lNCY/EX+zVXCCx4nMZtYVK2wPq2uzHN1Z0arxaWky35yMWn6
         RgG2cweeVpB6E0kIU0cmID1yFZEEMnD6mQwZglt0fB6ZbyQFaRIA13TYnc0ZCrAZpfYE
         raLlCo8Ri3QchJB+C48hL4QNAN4U43zeeN++4gpoiwSZEwLMMnGb9Ap+ogXDh934dY7c
         afsv4IK5ae46JTrZlN+RaEp96cOmcF7KzR2+eLuLc1yX2tbOCg5V7vJih1Cw1amSeAa1
         cI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698666972; x=1699271772;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I2EsWXgIgmY5ZGNZVcIKTU41YQY+qsuJewdFxQvk8sU=;
        b=jsBtHvEJiFGeQTTBjQmbyjvkgyTWS+Lsnsvse2QM4y8IwHvJzE84CJa1SqIvt8Fhkd
         1xVzpH1ZwlkUvKYdaEY3hdpY003aROvxI+QVpfuLGG71INemdfh2k5MHZ2ciJK7wkDxL
         NpfNMelKprRjp5k8uMJ4QkEBh4dZufIGqaih23ruvgkNbnfts1LoN0SOnw3cdH0dlc+K
         IcRQsfLDC68z1d4M0OQav54zoTPPijabXOtRx2XEow40/Ndx1X/II5GClhW8Wq7mtW8Y
         bvC6CgdskV7OZMZutgIPr3eyQF8jyzqyPyfX5cKiNRNvCkaq5rr1dujB4hdz/wnvMDtf
         +E6Q==
X-Gm-Message-State: AOJu0Yxsy8QRU2X8KI5VgHMWZbYGguErunn5D8co5r63zQu3sYp2XFmb
	pXr97xYa+ch1GNOVDruocOgdC95TFsU=
X-Google-Smtp-Source: AGHT+IF8MZGew12OSZI11Lfe9dH8VaY+T/WGta4GB8O2TuG6sWfbvwPqASaqM1IJrcLEyX0cF3UeEg==
X-Received: by 2002:a0c:f112:0:b0:66d:1b62:5c22 with SMTP id i18-20020a0cf112000000b0066d1b625c22mr8819699qvl.0.1698666971969;
        Mon, 30 Oct 2023 04:56:11 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id l15-20020ad44bcf000000b0065b2be40d58sm3327287qvw.25.2023.10.30.04.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 04:56:11 -0700 (PDT)
Message-ID: <1a87a53c-e95a-40c4-a410-0929a29456cc@gmail.com>
Date: Mon, 30 Oct 2023 04:56:09 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/15] doc: PKEX support for DPP
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231026202657.183591-1-prestwoj@gmail.com>
 <20231026202657.183591-13-prestwoj@gmail.com>
 <35ca1bec-2ccb-4e23-8b98-f6dffa4675ac@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <35ca1bec-2ccb-4e23-8b98-f6dffa4675ac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 10/29/23 3:27 PM, Denis Kenzior wrote:
> Hi James,
> 
> On 10/26/23 15:26, James Prestwood wrote:
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
>> PKEX would be used via the three DBus APIs on a new interface
>> SharedCodeDeviceProvisioning.
>>
>> ConfigureEnrollee(a{sv}) will start a configurator with a
>> static shared code (optionally identifier) passed in with the
>> dictionary key.
>>
>> StartConfigurator(object agent_path) will start listening and
>> wait for an Enrollee to send a PKEX exchange request. Once
>> received the configurator will call out to an agent
>> (distinguished by 'agent_path') and request the code using the
>> identifier sent by the enrollee. If no identifier was sent the
>> protocol will fail. This method allows for configuring one of
>> several enrollees, assuming the agent has the ability to
>> look up the identifier.
>>
>> StartEnrollee(a{sv}) will start a PKEX enrollee. Enrollees will
>> begin iterating a channel list sending out PKEX exchange
>> requests and waiting for a configurator to respond.
>>
>> After the PKEX protocol is finished, DPP bootstrapping keys have
>> been exchanged and DPP Authentication will start, followed by
>> configuration.
>> ---
>>   doc/device-provisioning-api.txt | 67 +++++++++++++++++++++++++++++++++
>>   1 file changed, 67 insertions(+)
>>
> 
> Okay, though much of this should be in the API doc itself.
> 
>> diff --git a/doc/device-provisioning-api.txt 
>> b/doc/device-provisioning-api.txt
>> index ac204f46..02856571 100644
>> --- a/doc/device-provisioning-api.txt
>> +++ b/doc/device-provisioning-api.txt
>> @@ -71,3 +71,70 @@ Properties    boolean Started [readonly]
>>               Indicates the DPP URI. This property is only available
>>               when Started is true.
>> +
>> +
>> +Interface    net.connman.iwd.SharedCodeDeviceProvisioning [Experimental]
>> +Object path    /net/connman/iwd/{phy0,phy1,...}/{1,2,...}
>> +
>> +        ConfigureEnrollee(a{sv})
>> +            Starts a DPP configurator using a shared code (and
>> +            optionally identifier) set in the dictionary argument.
>> +            Valid dictionary keys are:
>> +
>> +            {
>> +                Code: <The shared code to use>
>> +                Identifier: <Optional identifier>
>> +            }
> 
> You really need to specify the types of the entries.  Since you repeat 
> this at least twice, this may need to be a separate section.
> 
>> +
>> +            As with the DeviceProvisioning interface, configurators
>> +            must be currently connected to start.
>> +
>> +            Possible errors:    net.connman.iwd.Busy
>> +                        net.connman.iwd.NotConnected
>> +                        net.connman.InvalidArguments
>> +
>> +        StartConfigurator(object agent_path)
>> +            Start a shared code configurator using an agent to
>> +            obtain the shared code. This method is meant for an
>> +            automated use case where a configurator is capable of
>> +            configuring multiple enrollees, and distinguishing
>> +            between them by their identifier.
>> +
>> +            After starting the configurator will listen on channel.
>> +            Upon receiving an enrollees initial request it will
>> +            make an agent call (on 'agent_path') to obtain the
>> +            code associated with the enrollee.
>> +
>> +            As with the DeviceProvisioning interface, configurators
>> +            must be currently connected to start.
>> +
>> +            Possible errors:    net.connman.iwd.Busy
>> +                        net.connman.iwd.NotConnected
>> +                        net.connman.iwd.InvalidArguments
> 
> Where is the agent documentation?

I wanted to get your preference, I can add a separate agent API 
specifically for shared code (RequestSharedCode), or we can piggy back 
off (since its the same signature):

RequestUserPassword(object network, string user)

Either way, I'll add more information about the agent interaction.

> 
>> +
>> +        StartEnrollee(a{sv})
>> +            Start a shared code enrollee using the Code and
>> +            optionally identifier passed in the dictionary argument.
>> +            As with the configurator, valid dictionary keys are:
>> +
>> +            {
>> +                Code: <The shared code to use>
>> +                Identifier: <Optional identifier>
>> +            }
>> +
>> +            As with the DeviceProvisioning interface, enrollees
>> +            must be disconnected in order to start.
>> +
>> +            Possible errors:    net.connman.iwd.Busy
>> +                        net.connman.iwd.InvalidArguments
>> +
>> +Properties    boolean Started [readonly]
>> +
>> +            True if shared code device provisioning is currently
>> +            active. (configurator or enrollee is started)
>> +
>> +        string Role [readonly, optional]
>> +
>> +            Indicates the DPP role. Possible values are "enrollee"
>> +            or "configurator". This property is only available when
>> +            Started is true.
> 
> Regards,
> -Denis
