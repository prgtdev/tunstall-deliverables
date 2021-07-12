CREATE OR REPLACE VIEW RECEIPT_REFERENCE AS
SELECT DISTINCT
       receipt_reference              receipt_reference,
       source_ref1                    source_ref1,
       arrival_date                   arrival_date,
       rowid                          objid,
       rowversion                     objversion,
       rowkey                         objkey,
       receipt_sequence               receipt_sequence,
       source_ref2                    source_ref2,
       source_ref3                    source_ref3,
       source_ref4                    source_ref4,
       Logistics_Source_Ref_Type_API.Decode(source_ref_type) source_ref_type,
       source_ref_type                source_ref_type_db,
       receipt_no                     receipt_no,
       contract                       contract,
       source_part_no                 source_part_no,
       description                    description,
       note_text                      note_text,
       conv_factor                    conv_factor,
       inv_unit_meas                  inv_unit_meas,
       source_unit_meas               source_unit_meas,
       source_qty_arrived             source_qty_arrived,
       inv_qty_arrived                inv_qty_arrived,
       catch_qty_arrived              catch_qty_arrived,
       source_qty_inspected           source_qty_inspected,
       source_qty_to_inspect          source_qty_to_inspect,
       delivery_date                  delivery_date,
       approved_date                  approved_date,
       receiver                       receiver,
       sender                         sender,
       Sender_Receiver_Type_API.Decode(sender_type) sender_type,
       sender_type                    sender_type_db,
       qc_code                        qc_code,
       no_of_inspections              no_of_inspections,
       Receive_Case_API.Decode(receive_case) receive_case,
       receive_case                   receive_case_db,
       note_id                        note_id,
       Fnd_Boolean_API.Decode(printed_arrival_flag) printed_arrival_flag,
       printed_arrival_flag           printed_arrival_flag_db,
       Fnd_Boolean_API.Decode(printed_return_flag) printed_return_flag,
       printed_return_flag            printed_return_flag_db,
       airway_bill_no                 airway_bill_no,
       Fnd_Boolean_API.Decode(inventory_part) inventory_part,
       inventory_part                 inventory_part_db,
       rowstate                       objstate,
       Receipt_Info_API.Finite_State_Events__(rowstate)                     objevents,
       Receipt_Info_API.Finite_State_Decode__(rowstate)  state
FROM   receipt_info_tab r
WHERE  receipt_reference IS NOT NULL
AND    rowstate != 'Cancelled'
AND    source_ref_type = 'PURCHASE_ORDER'
AND    EXISTS (SELECT 1 FROM user_allowed_site_pub s
               WHERE s.site = r.contract)
WITH   READ ONLY;
comment on table RECEIPT_REFERENCE is 'LU=ReceiptInfo^PROMPT=Receipt Reference^MODULE=RCEIPT^';
comment on column RECEIPT_REFERENCE.RECEIPT_REFERENCE is 'FLAGS=K---L^DATATYPE=STRING(50)/UPPERCASE^PROMPT=Receipt Ref^';
comment on column RECEIPT_REFERENCE.SOURCE_REF1 is 'FLAGS=A---L^DATATYPE=STRING(50)^PROMPT=Source Ref 1^';
comment on column RECEIPT_REFERENCE.ARRIVAL_DATE is 'FLAGS=A---L^DATATYPE=DATE/DATETIME^PROMPT=Arrival Date^';
comment on column RECEIPT_REFERENCE.RECEIPT_SEQUENCE is 'FLAGS=A----^DATATYPE=NUMBER^PROMPT=Receipt Sequence^';
comment on column RECEIPT_REFERENCE.SOURCE_REF2 is 'FLAGS=A-I--^DATATYPE=STRING(50)^PROMPT=Source Ref 2^';
comment on column RECEIPT_REFERENCE.SOURCE_REF3 is 'FLAGS=A-I--^DATATYPE=STRING(50)^PROMPT=Source Ref 3^';
comment on column RECEIPT_REFERENCE.SOURCE_REF4 is 'FLAGS=A-I--^DATATYPE=STRING(50)^PROMPT=Source Ref 4^';
comment on column RECEIPT_REFERENCE.SOURCE_REF_TYPE is 'FLAGS=A-I--^DATATYPE=STRING(200)^ENUMERATION=LogisticsSourceRefType^PROMPT=Source Ref Type^';
comment on column RECEIPT_REFERENCE.SOURCE_REF_TYPE_DB is 'FLAGS=A----^DATATYPE=STRING(20)^PROMPT=Source Ref Type^';
comment on column RECEIPT_REFERENCE.RECEIPT_NO is 'FLAGS=AMI--^DATATYPE=NUMBER^PROMPT=Receipt No^';
comment on column RECEIPT_REFERENCE.CONTRACT is 'FLAGS=A-I--^DATATYPE=STRING(5)/UPPERCASE^PROMPT=Site^';
comment on column RECEIPT_REFERENCE.SOURCE_PART_NO is 'FLAGS=A-I--^DATATYPE=STRING(50)^PROMPT=Source Part No^';
comment on column RECEIPT_REFERENCE.DESCRIPTION is 'FLAGS=A-IU-^DATATYPE=STRING(2000)^PROMPT=Description^';
comment on column RECEIPT_REFERENCE.NOTE_TEXT is 'FLAGS=A-IU-^DATATYPE=STRING(2000)^PROMPT=Note Text^';
comment on column RECEIPT_REFERENCE.CONV_FACTOR is 'FLAGS=A-IU-^DATATYPE=NUMBER^PROMPT=Conv Factor^';
comment on column RECEIPT_REFERENCE.INV_UNIT_MEAS is 'FLAGS=A-IU-^DATATYPE=STRING(10)^PROMPT=Inv Unit Meas^REF=IsoUnit^';
comment on column RECEIPT_REFERENCE.SOURCE_UNIT_MEAS is 'FLAGS=A-IU-^DATATYPE=STRING(10)^PROMPT=Source Unit Meas^REF=IsoUnit^';
comment on column RECEIPT_REFERENCE.SOURCE_QTY_ARRIVED is 'FLAGS=A-IU-^DATATYPE=NUMBER^PROMPT=Qty Arrived^';
comment on column RECEIPT_REFERENCE.INV_QTY_ARRIVED is 'FLAGS=A-IU-^DATATYPE=NUMBER^PROMPT=Inv Qty Arrived^';
comment on column RECEIPT_REFERENCE.CATCH_QTY_ARRIVED is 'FLAGS=A-IU-^DATATYPE=NUMBER^PROMPT=Catch Qty Arrived^';
comment on column RECEIPT_REFERENCE.SOURCE_QTY_INSPECTED is 'FLAGS=A--U-^DATATYPE=NUMBER^PROMPT=Source Qty Inspected^';
comment on column RECEIPT_REFERENCE.SOURCE_QTY_TO_INSPECT is 'FLAGS=A-IU-^DATATYPE=NUMBER^PROMPT=Qty to Inspect^';
comment on column RECEIPT_REFERENCE.DELIVERY_DATE is 'FLAGS=A-IU-^DATATYPE=DATE/DATE^PROMPT=Actual Delivery Date^';
comment on column RECEIPT_REFERENCE.APPROVED_DATE is 'FLAGS=A-IU-^DATATYPE=DATE/DATE^PROMPT=Approved Date^';
comment on column RECEIPT_REFERENCE.RECEIVER is 'FLAGS=A-IU-^DATATYPE=STRING(30)^PROMPT=Receiver^';
comment on column RECEIPT_REFERENCE.SENDER is 'FLAGS=A-IU-^DATATYPE=STRING(20)^PROMPT=Sender^';
comment on column RECEIPT_REFERENCE.SENDER_TYPE is 'FLAGS=A-I--^DATATYPE=STRING(200)^ENUMERATION=SenderReceiverType^PROMPT=Sender Type^';
comment on column RECEIPT_REFERENCE.SENDER_TYPE_DB is 'FLAGS=A----^DATATYPE=STRING(20)^PROMPT=Sender Type^';
comment on column RECEIPT_REFERENCE.QC_CODE is 'FLAGS=A-IU-^DATATYPE=STRING(20)/UPPERCASE^PROMPT=Qc Code^REF=QualityCtrlAnalyst^';
comment on column RECEIPT_REFERENCE.NO_OF_INSPECTIONS is 'FLAGS=A--U-^DATATYPE=NUMBER^PROMPT=No of Inspections^';
comment on column RECEIPT_REFERENCE.RECEIVE_CASE is 'FLAGS=A-IUL^DATATYPE=STRING(200)^ENUMERATION=ReceiveCase^PROMPT=Receive Case^';
comment on column RECEIPT_REFERENCE.RECEIVE_CASE_DB is 'FLAGS=A----^DATATYPE=STRING(20)^PROMPT=Receive Case^';
comment on column RECEIPT_REFERENCE.NOTE_ID is 'FLAGS=A----^DATATYPE=NUMBER^PROMPT=Note Id^';
comment on column RECEIPT_REFERENCE.PRINTED_ARRIVAL_FLAG is 'FLAGS=A-IU-^DATATYPE=STRING(200)^ENUMERATION=FndBoolean^PROMPT=Printed Arrival Flag^';
comment on column RECEIPT_REFERENCE.PRINTED_ARRIVAL_FLAG_DB is 'FLAGS=A----^DATATYPE=STRING(5)^PROMPT=Printed Arrival Flag^';
comment on column RECEIPT_REFERENCE.PRINTED_RETURN_FLAG is 'FLAGS=A-IU-^DATATYPE=STRING(200)^ENUMERATION=FndBoolean^PROMPT=Printed Return Flag^';
comment on column RECEIPT_REFERENCE.PRINTED_RETURN_FLAG_DB is 'FLAGS=A----^DATATYPE=STRING(5)^PROMPT=Printed Return Flag^';
comment on column RECEIPT_REFERENCE.AIRWAY_BILL_NO is 'FLAGS=A-I--^DATATYPE=STRING(50)^PROMPT=Airway Bill No^';
comment on column RECEIPT_REFERENCE.INVENTORY_PART is 'FLAGS=A-I--^DATATYPE=STRING(200)^ENUMERATION=FndBoolean^PROMPT=Inventory Part^';
comment on column RECEIPT_REFERENCE.INVENTORY_PART_DB is 'FLAGS=A----^DATATYPE=STRING(5)^PROMPT=Inventory Part^';
comment on column RECEIPT_REFERENCE.STATE is 'FLAGS=A----^DATATYPE=STRING(20)^PROMPT=State^';
