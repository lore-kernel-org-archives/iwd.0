Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21177C
	for <iwd@lists.linux.dev>; Thu, 13 Jul 2023 02:53:52 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D2D4eh003770;
	Thu, 13 Jul 2023 02:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Y5nMReRJPtdJDERBv4RkYJiunzVE1px1vDSXsFptxnc=;
 b=UOZrRFrAP2CiApiME8gUFbYfjJdCVqiEpgfrBKoXoFPXmIS02DiW1x3rBK6BkeQQ5mlC
 609dgOFFKxdn3uQmn8p8L8pzm3ZKWKpKHqKkY9oKAVDDwuNqn0FEaVvCm3EppcqluqCo
 G/pjySEs/zvYBsGK7ax7HzhMISRiG0eQ4RCOeUjXysdqa/c9MvrSdRifsHJMU06tM1oz
 qxUgDL4U7ZuVKGPmCox8apqdUxExc+/SSAWdC0ER/zkAUmN0M3JO2+lkA/m4vqoPB3ek
 9r806FHq3DySb0ozX1SM1XXV0n4S/8193Cpnm7UAsYNLBzJ1syJj8WEkHRQka1+dOm0K Bw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rt89tr1qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jul 2023 02:52:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36D2qnru012951
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jul 2023 02:52:49 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 12 Jul
 2023 19:52:48 -0700
Message-ID: <03b87aea-9d3b-78b5-e187-94c4310982cb@quicinc.com>
Date: Thu, 13 Jul 2023 10:52:45 +0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/3] owe: netdev: refactor to remove OWE as an
 auth-proto
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, <iwd@lists.01.org>,
        <iwd@lists.linux.dev>
CC: Denis Kenzior <denkenz@gmail.com>
References: <20210903193544.13897-3-prestwoj@gmail.com>
 <a7e76f73-da60-57fd-6686-b26e5c342d87@quicinc.com>
 <411c867b-f830-c66c-4c21-f59200993b2a@gmail.com>
 <00246aa8-fe45-f5c2-cf2a-3450cee414f2@quicinc.com>
 <d2a490cf-ae06-ed26-33eb-5475616bd725@gmail.com>
From: Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <d2a490cf-ae06-ed26-33eb-5475616bd725@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YUbUuFBr-8mBMEZGJtaGeOsGAm4_HY0y
X-Proofpoint-GUID: YUbUuFBr-8mBMEZGJtaGeOsGAm4_HY0y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_17,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 mlxlogscore=999 suspectscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130023

On 7/13/2023 10:33 AM, James Prestwood wrote:
> Hi Wen,
>
> On 7/12/23 7:23 PM, Wen Gong wrote:
>> On 7/12/2023 10:52 PM, James Prestwood wrote:
>>> Hi Wen,
>>>
>>> On 7/12/23 4:17 AM, Wen Gong wrote:
>>>> On 9/4/2021 3:35 AM, James Prestwood wrote:
>>>>> ---
>>>> ...
>>>>> +
>>>>> +            case IE_TYPE_RSN:
>>>>> +                if (!netdev->owe_sm)
>>>>> +                    continue;
>>>>> +
>>>>> +                if (ie_parse_rsne(&iter, &info) < 0) {
>>>>> +                    l_error("could not parse RSN IE");
>>>>> +                    goto error;
>>>>> +                }
>>>>> +
>>>>> +                /*
>>>>> +                 * RFC 8110 Section 4.2
>>>>> +                 * An AP agreeing to do OWE MUST include the OWE 
>>>>> AKM in
>>>>> +                 * the RSN element portion of the 802.11 association
>>>>> +                 * response.
>>>>> +                 */
>>>> Now it is happen connect to OWE AP fail with some APs, because the 
>>>> assoc resp do not inclued RSNE.
>>>>> +                if (info.akm_suites != IE_RSN_AKM_SUITE_OWE) {
>>>>> +                    l_error("OWE AKM not included");
>>>>> +                    goto deauth;
>>>>> +                }
>>>>> +
>>>>> +                owe_akm_found = true;
>>>>> +
>>>>> +                break;
>>>>> +            }
>>>>> +        }
>>>>> +
>>>>> +        if (netdev->owe_sm) {
>>>>> +            if (!owe_dh || !owe_akm_found) {
>>>>> +                l_error("OWE DH element/RSN not found");
>>>>
>>>> It failed here.
>>>>
>>>> So is the check for owe_akm_found MUST added here if owe_dh is 
>>>> existed in assoc resp?
>>>
>>> As the comment states, the OWE RFC says that the RSN element must be 
>>> included in the associate response if we are to stay compliant with 
>>> the spec.
>>>
>>> But as you may have noticed we don't actually do anything with this 
>>> element besides parse it. I don't see that wpa_supplicant enforces 
>>> this either, so it may be fine to relax this check.
>> Thanks for you to relax the check.
>>>
>>> I would prefer to see iwmon logs when you connect to this AP, just 
>>> to confirm that the AP isn't including the IE and not something 
>>> else. Would you be able to get those?
>>>
>> I have collected iwd log with hexdump, it does not include RSNIE in 
>> assoc resp ies:
>
> Sorry, I should have been more specific. Using IWD_GENL_DEBUG does 
> contain the information, but its not really a readable format. We have 
> a tool called iwmon which you run in parallel to IWD. This parses the 
> raw data and displays a human readable output:

Hi James,

I added the hexdump here:

Jul 11 03:06:23.493780 iwd[992]: src/netdev.c:netdev_mlme_notify() MLME 
notification Associate(38)
Jul 11 03:06:23.493780 iwd[992]: src/netdev.c:netdev_associate_event()
Jul 11 03:06:23.493780 iwd[992]: [GENL] < ac 01 00 00 22 00 00 00 00 00 
00 00 00 00 00 00  ...."...........
Jul 11 03:06:23.493780 iwd[992]: [GENL]   2e 01 00 00 08 00 01 00 00 00 
00 00 08 00 03 00  ................
Jul 11 03:06:23.493780 iwd[992]: [GENL]   04 00 00 00 0a 00 06 00 fc 34 
97 2b 1b 48 00 00  .........4.+.H..
Jul 11 03:06:23.493780 iwd[992]: [GENL]   06 00 48 00 00 00 00 00 ac 00 
4d 00 00 09 41 53  ..H.......M...AS //ac 00 4d 00:assoc req ies 
start//NL80211_ATTR_REQ_IE=0x4d//00 09:SSID IE
Jul 11 03:06:23.493780 iwd[992]: [GENL]   55 53 2d 36 47 41 50 01 08 0c 
12 18 24 30 48 60  US-6GAP.....$0H`
Jul 11 03:06:23.493780 iwd[992]: [GENL]   6c 21 02 00 14 30 14 01 00 00 
0f ac 04 01 00 00  l!...0..........
Jul 11 03:06:23.493780 iwd[992]: [GENL]   0f ac 04 01 00 00 0f ac 12 c0 
00 46 05 70 00 00  ...........F.p..
Jul 11 03:06:23.493780 iwd[992]: [GENL]   00 00 7f 0a 04 00 48 00 01 00 
00 40 00 21 ff 21  ......H....@.!.!
Jul 11 03:06:23.493780 iwd[992]: [GENL]   23 0b 00 10 9a 40 08 0c 33 4c 
89 fd 09 80 c8 0e  #....@..3L......
Jul 11 03:06:23.493780 iwd[992]: [GENL]   0c 00 fa ff fa ff fa ff fa ff 
79 1c c7 71 1c c7  ..........y..q..
Jul 11 03:06:23.493780 iwd[992]: [GENL]   71 ff 03 3b b8 36 ff 33 20 14 
00 37 0b b6 af ec  q..;.6.3 ..7....
Jul 11 03:06:23.493780 iwd[992]: [GENL]   e8 7f 96 b6 1c e4 90 b9 bb 79 
ff 00 65 7c 42 1e  .........y..e|B.
Jul 11 03:06:23.493780 iwd[992]: [GENL]   d5 55 4b 6b b9 94 03 ec 83 3f 
6a 22 60 71 56 83  .UKk.....?j"`qV.
Jul 11 03:06:23.493780 iwd[992]: [GENL]   b5 94 51 ca a7 62 ed b7 77 e5 
09 dd 07 00 50 f2  ..Q..b..w.....P.
Jul 11 03:06:23.495574 iwd[992]: [GENL]   02 00 01 00 c8 00 4e 00 01 08 
8c 12 98 24 b0 48  ......N......$.H //c8 00 4e 00: assoc resp ies 
start//NL80211_ATTR_RESP_IE=0x4e //01 08: Supported Rates ie
Jul 11 03:06:23.495574 iwd[992]: [GENL]   60 6c 46 05 30 00 00 00 00 7f 
0b 04 00 48 80 01  `lF.0........H..
Jul 11 03:06:23.495574 iwd[992]: [GENL]   00 00 c0 01 00 01 ff 27 23 01 
00 08 12 00 10 4c  .......'#......L
Jul 11 03:06:23.495574 iwd[992]: [GENL]   20 02 c0 6d 5b 81 18 00 8c 00 
aa ff aa ff aa ff   ..m[...........
Jul 11 03:06:23.495574 iwd[992]: [GENL]   aa ff 7b 1c c7 71 1c c7 71 1c 
c7 71 1c c7 71 ff  ..{..q..q..q..q.
Jul 11 03:06:23.495574 iwd[992]: [GENL]   0c 24 04 00 03 16 fc ff 45 03 
47 4f 00 ff 0e 26  .$......E.GO...&
Jul 11 03:06:23.495574 iwd[992]: [GENL]   08 00 a4 08 20 a4 08 40 43 08 
60 32 08 ff 03 3b  .... ..@C.`2...;
Jul 11 03:06:23.495574 iwd[992]: [GENL]   7d 06 ff 33 20 14 00 3e 00 1d 
bd 9a b8 80 23 76  }..3 ..>......#v
Jul 11 03:06:23.495574 iwd[992]: [GENL]   f6 22 23 a3 2a e0 77 73 5b 3d 
61 88 b9 34 fe 97  ."#.*.ws[=a..4..
Jul 11 03:06:23.495574 iwd[992]: [GENL]   3e c9 2c 7d b8 9b da 2b ed 82 
5a 11 af e7 6a 27  >.,}...+..Z...j'
Jul 11 03:06:23.495574 iwd[992]: [GENL]   07 bd 1b fc 19 94 13 dd 09 00 
10 18 02 00 00 9c  ................
Jul 11 03:06:23.495574 iwd[992]: [GENL]   00 00 dd 18 00 50 f2 02 01 01 
88 00 03 a4 00 00  .....P..........
Jul 11 03:06:23.495574 iwd[992]: [GENL]   27 a4 00 00 42 43 5e 00 62 32 
2f 00              '...BC^.b2/.  //assoc resp ies end, no RSNIE from 
start to end
Jul 11 03:06:23.495574 iwd[992]: src/netdev.c:netdev_mlme_notify() MLME 
notification Connect(46)
Jul 11 03:06:23.495574 iwd[992]: src/netdev.c:netdev_connect_event()
Jul 11 03:06:23.495574 iwd[992]: OWE DH element/RSN not found

also I collected air sniffer packet here(the assoc req/resp is in the 
same connection,
they are not same connection with above iwd hexdump, but they are 
connect with the same station/AP and same configuration,
so the hex dump between air sniffer and iwd log is similar):

======================Association Request start======================
copied from wireshark:

Frame 2352: 244 bytes on wire (1952 bits), 244 bytes captured (1952 
bits) on interface 0
Radiotap Header v0, Length 48
802.11 radio information
     PHY type: 802.11a (5)
     Turbo type: Non-turbo (0)
     Data rate: 6.0 Mb/s
     Frequency: 6295MHz
     Signal strength (dBm): -38dBm
     Noise level (dBm): 0dBm
     Signal/noise ratio (dB): -38dB
     TSF timestamp: 587853865856
     [Duration: 288µs]
IEEE 802.11 Association Request, Flags: ........
     Type/Subtype: Association Request (0x0000)
     Frame Control Field: 0x0000
     .000 0000 0011 1100 = Duration: 60 microseconds
     Receiver address: fc:34:97:2b:1b:48
     Destination address: fc:34:97:2b:1b:48
     Transmitter address: 64:c4:03:88:ff:26
     Source address: 64:c4:03:88:ff:26
     BSS Id: fc:34:97:2b:1b:48
     .... .... .... 0000 = Fragment number: 0
     0000 0111 0010 .... = Sequence number: 114
IEEE 802.11 wireless LAN
     Fixed parameters (4 bytes)
     Tagged parameters (168 bytes)
         Tag: SSID parameter set: ASUS-6GAP
         Tag: Supported Rates 6, 9, 12, 18, 24, 36, 48, 54, [Mbit/sec]
         Tag: Power Capability Min: 0, Max: 20
         Tag: RSN Information
             Tag Number: RSN Information (48)
             Tag length: 20
             RSN Version: 1
             Group Cipher Suite: 00:0f:ac (Ieee 802.11) AES (CCM)
                 Group Cipher Suite OUI: 00:0f:ac (Ieee 802.11)
                 Group Cipher Suite type: AES (CCM) (4)
             Pairwise Cipher Suite Count: 1
             Pairwise Cipher Suite List 00:0f:ac (Ieee 802.11) AES (CCM)
                 Pairwise Cipher Suite: 00:0f:ac (Ieee 802.11) AES (CCM)
                     Pairwise Cipher Suite OUI: 00:0f:ac (Ieee 802.11)
                     Pairwise Cipher Suite type: AES (CCM) (4)
             Auth Key Management (AKM) Suite Count: 1
             Auth Key Management (AKM) List 00:0f:ac (Ieee 802.11) 
Opportunistic Wireless Encryption
                 Auth Key Management (AKM) Suite: 00:0f:ac (Ieee 802.11) 
Opportunistic Wireless Encryption
                     Auth Key Management (AKM) OUI: 00:0f:ac (Ieee 802.11)
                     Auth Key Management (AKM) type: Opportunistic 
Wireless Encryption (18)
             RSN Capabilities: 0x00c0
                 .... .... .... ...0 = RSN Pre-Auth capabilities: 
Transmitter does not support pre-authentication
                 .... .... .... ..0. = RSN No Pairwise capabilities: 
Transmitter can support WEP default key 0 simultaneously with Pairwise key
                 .... .... .... 00.. = RSN PTKSA Replay Counter 
capabilities: 1 replay counter per PTKSA/GTKSA/STAKeySA (0x0)
                 .... .... ..00 .... = RSN GTKSA Replay Counter 
capabilities: 1 replay counter per PTKSA/GTKSA/STAKeySA (0x0)
                 .... .... .1.. .... = Management Frame Protection 
Required: True
                 .... .... 1... .... = Management Frame Protection 
Capable: True
                 .... ...0 .... .... = Joint Multi-band RSNA: False
                 .... ..0. .... .... = PeerKey Enabled: False
         Tag: RM Enabled Capabilities (5 octets)
         Tag: Extended Capabilities (10 octets)
         Ext Tag: HE Capabilities (IEEE Std 802.11ax/D3.0)
         Ext Tag: HE 6GHz Band Capabilities
         Ext Tag: OWE Diffie-Hellman Parameter
             Tag Number: Element ID Extension (255)
             Ext Tag length: 51
             Ext Tag Number: OWE Diffie-Hellman Parameter (32)
             Group: 384-bit random ECP group (20)
             Public Key: 011630d7fd22d7abc64ce11278bd9f3a4a262222bc0d4d1d…
         Tag: Vendor Specific: Microsoft Corp.: WMM/WME: Information Element

hex byte copied from air sniffer wireshark
IEEE 802.11 Association Request, Flags: ........
0000   00 00 3c 00 fc 34 97 2b 1b 48 64 c4 03 88 ff 26 ..<..4.+.Hd....&
0010   fc 34 97 2b 1b 48 20 07                           .4.+.H .

IEEE 802.11 wireless LAN
0000   11 10 05 00 00 09 41 53 55 53 2d 36 47 41 50 01 ......ASUS-6GAP.
0010   08 0c 12 18 24 30 48 60 6c 21 02 00 14 30 14 01 ....$0H`l!...0..
0020   00 00 0f ac 04 01 00 00 0f ac 04 01 00 00 0f ac ................
0030   12 c0 00 46 05 70 00 00 00 00 7f 0a 04 00 48 00 ...F.p........H.
0040   01 00 00 40 00 21 ff 21 23 0b 00 10 9a 40 08 0c ...@.!.!#....@..
0050   33 4c 89 fd 09 80 c8 0e 0c 00 fa ff fa ff fa ff 3L..............
0060   fa ff 79 1c c7 71 1c c7 71 ff 03 3b b8 36 ff 33 ..y..q..q..;.6.3
0070   20 14 00 01 16 30 d7 fd 22 d7 ab c6 4c e1 12 78 ....0.."...L..x
0080   bd 9f 3a 4a 26 22 22 bc 0d 4d 1d 7f bf e7 73 c9 ..:J&""..M....s.
0090   ba 43 a5 da 3e b2 c9 45 10 ba b8 e7 a4 ea ff ee .C..>..E........
00a0   09 8e 1c dd 07 00 50 f2 02 00 01 00 ......P.....
======================Association Request end======================

======================Association Response start======================

copied from wireshark:

Frame 2354: 274 bytes on wire (2192 bits), 274 bytes captured (2192 
bits) on interface 0
Radiotap Header v0, Length 48
802.11 radio information
     PHY type: 802.11a (5)
     Turbo type: Non-turbo (0)
     Data rate: 6.0 Mb/s
     Frequency: 6295MHz
     Signal strength (dBm): -45dBm
     Noise level (dBm): 0dBm
     Signal/noise ratio (dB): -45dB
     TSF timestamp: 587853891749
     [Duration: 328µs]
IEEE 802.11 Association Response, Flags: ........
     Type/Subtype: Association Response (0x0001)
     Frame Control Field: 0x1000
     .000 0000 0011 1100 = Duration: 60 microseconds
     Receiver address: 64:c4:03:88:ff:26
     Destination address: 64:c4:03:88:ff:26
     Transmitter address: fc:34:97:2b:1b:48
     Source address: fc:34:97:2b:1b:48
     BSS Id: fc:34:97:2b:1b:48
     .... .... .... 0000 = Fragment number: 0
     0001 1100 1000 .... = Sequence number: 456
IEEE 802.11 wireless LAN
     Fixed parameters (6 bytes)
     Tagged parameters (196 bytes)
         Tag: Supported Rates 6(B), 9, 12(B), 18, 24(B), 36, 48, 54, 
[Mbit/sec]
         Tag: RM Enabled Capabilities (5 octets)
         Tag: Extended Capabilities (11 octets)
         Ext Tag: HE Capabilities (IEEE Std 802.11ax/D3.0)
         Ext Tag: HE Operation (IEEE Std 802.11ax/D3.0)
         Ext Tag: MU EDCA Parameter Set
         Ext Tag: HE 6GHz Band Capabilities
         Ext Tag: OWE Diffie-Hellman Parameter
             Tag Number: Element ID Extension (255)
             Ext Tag length: 51
             Ext Tag Number: OWE Diffie-Hellman Parameter (32)
             Group: 384-bit random ECP group (20)
             Public Key: 14ba9d8abeb2ecd5d95e6c12491b16489d1bcc303e7a7fbd…
         Tag: Vendor Specific: Broadcom
         Tag: Vendor Specific: Microsoft Corp.: WMM/WME: Parameter Element

hex byte copied from air sniffer wireshark

IEEE 802.11 Association Response, Flags: ........
0000   10 00 3c 00 64 c4 03 88 ff 26 fc 34 97 2b 1b 48 ..<.d....&.4.+.H
0010   fc 34 97 2b 1b 48 80 1c                           .4.+.H..

IEEE 802.11 wireless LAN
0000   11 10 00 00 0b c0 01 08 8c 12 98 24 b0 48 60 6c ...........$.H`l
0010   46 05 30 00 00 00 00 7f 0b 04 00 48 80 01 00 00 F.0........H....
0020   c0 01 00 01 ff 27 23 01 00 08 12 00 10 4c 20 02 .....'#......L .
0030   c0 6d 5b 81 18 00 8c 00 aa ff aa ff aa ff aa ff .m[.............
0040   7b 1c c7 71 1c c7 71 1c c7 71 1c c7 71 ff 0c 24 {..q..q..q..q..$
0050   04 00 03 16 fc ff 45 03 47 4f 00 ff 0e 26 08 00 ......E.GO...&..
0060   a4 08 20 a4 08 40 43 08 60 32 08 ff 03 3b 7d 06   .. ..@C.`2...;}.
0070   ff 33 20 14 00 14 ba 9d 8a be b2 ec d5 d9 5e 6c   .3 ...........^l
0080   12 49 1b 16 48 9d 1b cc 30 3e 7a 7f bd 13 28 7b .I..H...0>z...({
0090   0c 84 e5 05 64 48 c1 ac 1e 78 38 db 33 7a 1e 5f ....dH...x8.3z._
00a0   71 9f 6f 11 b8 dd 09 00 10 18 02 00 00 9c 00 00 q.o.............
00b0   dd 18 00 50 f2 02 01 01 88 00 03 a4 00 00 27 a4 ...P..........'.
00c0   00 00 42 43 5e 00 62 32 2f 00 ..BC^.b2/.
======================Association Response end======================

>
> $ sudo iwmon --nortnl --nowiphy --noscan
>
I think above hexdump is readable/enough, if it is not, I will use iwmon 
to collect again.
> Denis,
>
> Is relaxing the RSNE check in the associate response (for OWE only) 
> something you'd be ok with? Obviously with an L_WARN_ON/l_warn message.
>
> Thanks,
> James
